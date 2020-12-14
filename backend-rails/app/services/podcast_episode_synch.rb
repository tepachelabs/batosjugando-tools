class PodcastEpisodeSynch
  def initialize(rss_reader = nil)
    @rss_reader = rss_reader || Rss::Reader.new
  end

  def call
    episodes = @rss_reader.call

    return [] if episodes.count.zero?

    save_all episodes
  end

  private

  def save_all(episodes)
    saved = []
    PodcastEpisode.transaction do
      episodes
        .reverse
        .each do |item|
        saved << PodcastEpisode.create(title: item.title,
                                       url: item.url,
                                       description: item.summary,
                                       audio_url: item.enclosure_url,
                                       season: item.itunes_season,
                                       episode: item.itunes_episode)
      end
    end

    saved
  end
end
