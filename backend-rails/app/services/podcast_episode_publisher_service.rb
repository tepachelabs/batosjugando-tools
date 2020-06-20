class PodcastEpisodePublisherService
  def call(user, publish_job)
    publish_service = instantiate_publish_service(publish_job.platform)
    publish_service.publish(user, publish_job)
  end

  private

  def instantiate_publish_service(platform)
    "#{platform.camelize}::PublishService".constantize.new
  end
end
