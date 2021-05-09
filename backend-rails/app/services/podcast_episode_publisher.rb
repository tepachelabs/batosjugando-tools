class PodcastEpisodePublisher
  def call(user, publish_job)
    raise StandardError('No publish configuration present!') if user.publish_configuration.nil?

    publish_service = instantiate_publish_service(publish_job.platform)
    publish_service.publish(user, publish_job)

    # if no errors... this means that we published it succesfully.
  rescue StandardError => e
    Sentry.with_scope do |scope|
      scope.set_extras(platform: publish_job.platform)
      scope.set_extras(user_id: user.id)
      scope.set_extras(episode_title: publish_job.podcast_episode.title)
    end

    Sentry.capture_exception(e)
    publish_job.update(status: 'failed')
  else
    publish_job.update(status: 'published')
  end

  private

  def instantiate_publish_service(platform)
    "#{platform.camelize}::Publish".constantize.new
  rescue NameError => e
    Sentry.extra_context platform: platform
    Sentry.capture_exception(e)
  end
end
