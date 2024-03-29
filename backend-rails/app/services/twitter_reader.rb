class TwitterReader
  def initialize(search_service = nil, discord_webhook_client = nil)
    @search_service = search_service || Twitter::Search.new
    @discord_webhook_client = discord_webhook_client || Discord::WebhookClient.new(discord_webhook)
  end

  def call
    last_published = LastPublished.find_by(twitter_username: 'batosjugando')
    tweets = @search_service.call(last_published)
    tweets.each do |tweet|
      send_to_discord(tweet.tweet_url)
      last_published.last_tweet_id = tweet.tweet_id
    end

    last_published.save
  end

  private

  def send_to_discord(message)
    @discord_webhook_client.send_message(message)
  end

  def discord_webhook
    ENV.fetch('BJ_DISCORD_WEBHOOK', nil)
  end
end
