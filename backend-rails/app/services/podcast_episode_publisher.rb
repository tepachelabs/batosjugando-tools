class PodcastEpisodePublisher
  def call(user, publish_job)
    raise StandardError('No publish configuration present!') if user.publish_configuration.nil?

    publish_service = instantiate_publish_service(publish_job.platform)
    publish_service.publish(user, publish_job)

    # if no errors... this means that we published it succesfully.
  rescue StandardError => e
    Raven.extra_context platform: publish_job.platform
    Raven.extra_context user_id: user.id
    Raven.extra_context episode_title: publish_job.podcast_episode.title

    Raven.capture_exception(e)
    publish_job.update(status: 'failed')
  else
    publish_job.update(status: 'published')
  end

  private

  def instantiate_publish_service(platform)
    "#{platform.camelize}::Publish".constantize.new
  rescue NameError => e
    Raven.extra_context platform: platform
    Raven.capture_exception(e)
  end
end
