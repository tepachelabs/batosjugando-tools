class Twitter::Publish < Publish::BaseService
  def publish(user, publish_job)
    publish_configuration = user.publish_configuration
    client = Twitter::GenerateClient.call(publish_configuration.twitter_oauth_token,
                                          publish_configuration.twitter_oauth_token_secret)
    episode = publish_job.podcast_episode
    tweet = client.update("#{episode.title} #{episode.url}")

    publish_job.update(published_url: tweet.try(:url)&.to_s)
    tweet
  end
end
