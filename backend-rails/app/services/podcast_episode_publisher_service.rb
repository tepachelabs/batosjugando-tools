class PodcastEpisodePublisherService
  def initialize(episode_reader = nil, reddit_publish_service = nil)
    @episode_reader = episode_reader || Anchor::RSSReaderService.new.call
    @reddit_publish_service = reddit_publish_service || Reddit::PublishService.new
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
    @reddit_publish_service.call(admin_user.reddit_token, episode)
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
