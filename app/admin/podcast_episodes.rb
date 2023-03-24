ActiveAdmin.register PodcastEpisode do
  menu parent: 'Podcast', label: 'Episodes'

  includes :publish_jobs
  actions :all, except: %i[destroy edit]

  action_item :refresh_episodes, only: :index do
    link_to 'Refresh Episodes', refresh_episodes_admin_podcast_episodes_path
  end

  action_item :publish_last_episode, only: :index do
    link_to 'Publish Last Episode', publish_last_episode_admin_podcast_episodes_path
  end

  collection_action :refresh_episodes, method: :get do
    PodcastEpisodeSynch.new.call
    redirect_to collection_path, notice: 'Episodes Refreshed!'
  end

  collection_action :publish_last_episode, method: :get do
    LastPodcastEpisodePublisherWorker.perform_async
    redirect_to collection_path, notice: 'Tried to publish last episode.'
  end

  index do
    id_column
    column :title
    column 'Published?' do |pe|
      if pe.publish_jobs.any?(&:status_published?)
        true
      elsif pe.publish_jobs.any?(&:status_in_progress?)
        'In Progress...'
      else
        a 'Publish', href: new_admin_publish_job_path(publish_job: { podcast_episode_id: pe })
      end
    end
    actions
  end

  controller do
    def permitted_params
      params.permit!
    end
  end
end
