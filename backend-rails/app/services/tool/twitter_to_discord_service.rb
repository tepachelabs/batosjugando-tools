class Tool::TwitterToDiscordService
  def call(last_published, tweets = [])
    tweets.each do |tweet|
      send_tweet_to_discord(tweet)
      last_published.last_tweet_id = tweet.tweet_id
    end

    last_published.save
  end

  private

  def send_tweet_to_discord(tweet)
    return unless discord_webhook.present?

    body = { content: tweet.tweet_url }.to_json
    HTTParty.post(discord_webhook, body: body, headers: { 'Content-Type' => 'application/json' })
  end

  def discord_webhook
    ENV['BJ_DISCORD_WEBHOOK']
  end
end
