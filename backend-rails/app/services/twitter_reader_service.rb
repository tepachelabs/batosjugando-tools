class TwitterReaderService
  def initialize(search_service = nil, twitter_to_discord = nil)
    @search_service = search_service || Twitter::SearchService.new
    @twitter_to_discord = twitter_to_discord || Tool::TwitterToDiscordService.new
  end

  def call
    last_published = LastPublished.find_by(twitter_username: 'batosjugando')
    tweets = @search_service.call(last_published)
    @twitter_to_discord.call(last_published, tweets)
  end
end
