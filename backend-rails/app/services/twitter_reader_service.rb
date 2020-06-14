class TwitterReaderService
  def initialize(search_service = nil, twitter_to_discord = nil)
    @search_service = search_service || Twitter::SearchService.new
    @twitter_to_discord = twitter_to_discord || Tool::TwitterToDiscordService.new
  end

  def call
    batos_jugando_reads = ReadTweet.find_by(username: 'batosjugando')
    tweets = @search_service.call(batos_jugando_reads)
    @twitter_to_discord.call(batos_jugando_reads, tweets)
  end
end
