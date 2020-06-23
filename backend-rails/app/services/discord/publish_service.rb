class Discord::PublishService < Publish::BaseService
  def publish(_user, publish_job)
    connection = connection(publish_job)
    connection.send_message(message(publish_job))
  end

  private

  def message(publish_job)
    publish_job.message || publish_job.podcast_episode.url
  end

  def connection(publish_job)
    # we can obtain the bot config from the publish job and not just use the webhook url.
    @connection ||= Discord::WebhookClient.new(publish_job.webhook_url)
  end
end
