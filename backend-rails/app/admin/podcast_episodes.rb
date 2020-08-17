ActiveAdmin.register PodcastEpisode do
  menu parent: 'Podcast', label: 'Episodes'

  includes :publish_jobs
  actions :all, except: %i[destroy edit]

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
