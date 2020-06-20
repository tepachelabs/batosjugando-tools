class LastPodcastEpisodePublisherService
  def initialize(episode_reader = nil, podcast_episode_publisher = nil)
    @episode_reader = episode_reader || Anchor::RSSReaderService.new.call
    @podcast_episode_publisher = podcast_episode_publisher || PodcastEpisodePublisherService.new
  end

  def call
    episodes = @episode_reader.call

    return if episodes.count.zero?

    save_all episodes

    puts 'Notification: more than 1 episode to publish, will publish last one.'
    publish(AdminUser.first, saved.first)
  end

  private

  def publish(admin_user, episode)
    # TODO here I should include each service... or somehow create a strategy to include them in a single place
    @podcast_episode_publisher.call(admin_user, episode, 'reddit')
  end

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
end
