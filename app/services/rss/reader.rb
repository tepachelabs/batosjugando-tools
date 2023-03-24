class Rss::Reader
  def initialize(include_all_episodes: false)
    @include_all_episodes = include_all_episodes
  end

  def call
    rss = read_rss
    episodes = []
    rss.entries.each do |item|
      episode = PodcastEpisode.find_by(url: item.url)
      break if episode.present? && !@include_all_episodes

      episodes << item
    end

    episodes
  end

  private

  def exists?(episode)
    episode.title.present?
  end

  def read_rss
    xml = HTTParty.get(feed_url).body
    Feedjira.parse(xml, parser: Feedjira::Parser::ITunesRSS)
  end

  def feed_url
    ENV.fetch('EL_HONGO_VERDE_RSS', nil)
  end
end
