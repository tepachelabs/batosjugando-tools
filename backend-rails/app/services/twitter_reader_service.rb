class TwitterReaderService
  def initialize(search_service = nil, discord_webhook_client = nil)
    @search_service = search_service || Twitter::SearchService.new
    @discord_webhook_client = discord_webhook_client || Discord::WebhookClient.new(discord_webhook)
  end

  def call
    last_published = LastPublished.find_by(twitter_username: 'batosjugando')
    tweets = @search_service.call(last_published)
    tweets.each do |tweet|
      send_to_discord(tweet.tweet_url)
      last_published.last_tweet_id = tweet.tweet_id
    end
  end

  private

  def send_to_discord(message)
    @discord_webhook_client.send_message(message)
  end

  def discord_webhook
    ENV['BJ_DISCORD_WEBHOOK']
  end
end
