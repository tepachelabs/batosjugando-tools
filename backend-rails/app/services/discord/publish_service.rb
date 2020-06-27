class Discord::PublishService < Publish::BaseService
  def publish(user, publish_job)
    publish_config = user.publish_configuration
    connection = connection(publish_config)
    connection.send_message(message(publish_job))
  end

  private

  def message(publish_job)
    publish_job.message || publish_job.podcast_episode.url
  end

  def connection(publish_config)
    @connection ||= Discord::WebhookClient.new(publish_config.discord_webhook_url)
  end
end
