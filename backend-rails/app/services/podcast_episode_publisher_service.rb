class PodcastEpisodePublisherService
  def initialize(episode_reader = nil)
    @episode_reader = episode_reader || Anchor::RSSReaderService.new.call
  end

  def call
    episodes = @episode_reader.call

    return if episodes.count.zero?

    save_all episodes

    return unless episodes.count > 1

    puts 'Notification: more than 1 episode to publish, will publish last one.'
    publish(saved.first)
  end

  private

  def save_all(episodes)
    saved = []
    PodcastEpisode.transaction do
      episodes.each do |item|
        saved << PodcastEpisode.create(title: item.title,
                                       url: item.url,
                                       description: item.summary,
                                       audio_url: item.enclosure_url,
                                       season: item.itunes_season,
                                       episode: item.itunes_episode)
      end
    end

    # do something if it fails lel!
    saved
  end

  def publish(_episode)
    puts 'publish lel!'
  end
end
