class PodcastEpisodePublisherService
  def call(user, publish_job)
    publish_service = instantiate_publish_service(publish_job.platform)
    publish_service.publish(user, publish_job)

    # if no errors... this means that we published it succesfully.
    publish_job.update(status: 'published')
  end

  private

  def instantiate_publish_service(platform)
    "#{platform.camelize}::PublishService".constantize.new
  rescue NameError => e
    Raven.extra_context platform: platform
    Raven.capture_exception(e)
  end
end
