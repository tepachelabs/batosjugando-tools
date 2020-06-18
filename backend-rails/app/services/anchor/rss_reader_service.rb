class Anchor::RSSReaderService
  def call
    rss = read_rss
    episodes = []
    rss.entries.each do |item|
      episode = PodcastEpisode.find_or_create_by(url: item.url)
      break if exists?(episode)

      episodes << episode
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
    ENV['EL_HONGO_VERDE_RSS']
  end
end
