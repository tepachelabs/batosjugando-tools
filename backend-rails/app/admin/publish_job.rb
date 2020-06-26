ActiveAdmin.register PublishJob do
  includes :podcast_episode
  actions :all, except: %i[destroy edit]

  index do
    id_column
    column 'Podcast Episode' do |e|
      e.podcast_episode.title
    end
    column :platform
    actions
  end

  form do |_f|
    inputs 'Details' do
      input :podcast_episode
      input :platform, as: :select, include_blank: false, collection: PublishJob::PLATFORMS_TO_PUBLISH
    end
    actions
  end

  controller do
    after_create :publish_to_platform

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
