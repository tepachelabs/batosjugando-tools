class Tool::TwitterToDiscordService

  def call(batos_jugando_reads, tweets = [])
    tweets.each do |tweet|
      send_tweet_to_discord(tweet)
      batos_jugando_reads.last_tweet_id = tweet.tweet_id
    end

    batos_jugando_reads.save
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
