class Tool::TwitterToDiscordService

  def initialize(search_service: Twitter::SearchService.new)
    @search_service = search_service
  end

  def call
    # @search_service.call
  end

end