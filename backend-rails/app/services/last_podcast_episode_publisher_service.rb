class LastPodcastEpisodePublisherService
  # push these to a configuration linked to an account and... this can be reused.
  PUBLISH_LIST_ORDER = %i[
    reddit
    discord
  ].freeze

  PUBLISH_CONFIG = {
    discord: ENV['BJ_DISCORD_WEBHOOK']
  }.freeze

  def initialize(rss_reader = nil, podcast_episode_publisher = nil)
    @rss_reader = rss_reader || Rss::ReaderService.new
    @podcast_episode_publisher = podcast_episode_publisher || PodcastEpisodePublisherService.new
  end

  def call
    episodes = @rss_reader.call

    return if episodes.count.zero?

    episodes = save_all episodes

    publish(AdminUser.first, episodes.first)
  end

  private

  def publish(admin_user, episode)
    PUBLISH_LIST_ORDER.each do |platform|
      publish_job = PublishJob.create(platform: platform,
                                      podcast_episode: episode,
                                      webhook_url: PUBLISH_CONFIG[platform])

      @podcast_episode_publisher.call(admin_user, publish_job)
    end
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
