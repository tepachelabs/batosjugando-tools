ActiveAdmin.register PublishJob do
  menu parent: 'Publish', label: 'Jobs'

  includes :podcast_episode
  actions :all, except: %i[destroy edit]

  index do
    id_column
    column 'Podcast Episode' do |e|
      e.podcast_episode.title
    end
    column :platform
    column :status do |e|
      if e.status_failed?
        a 'failed - click to retry', href: retry_admin_publish_job_path(e)
      else
        e.status
      end
    end
    actions
  end

  form do |_f|
    inputs 'Details' do
      input :podcast_episode
      input :platform, as: :select, include_blank: false, collection: PublishJob::PLATFORMS_TO_PUBLISH
    end
    actions
  end

  member_action :retry, method: :get do
    if resource.status_failed?
      resource.update(status: 'in_progress')
      SingleEpisodePublisherWorker.perform_async(current_admin_user.id, resource.id)
    end
    redirect_to admin_publish_jobs_path
  end

  controller do
    after_save :publish_to_platform

    private

    def publish_to_platform(publish_job)
      publish_job.update(status: 'in_progress')

      puts "Trying to publish episode #{publish_job.podcast_episode.title} to: #{publish_job.platform}"
      SingleEpisodePublisherWorker.perform_async(current_admin_user.id, publish_job.id)
    end

    def permitted_params
      params.permit!
    end
  end
end
