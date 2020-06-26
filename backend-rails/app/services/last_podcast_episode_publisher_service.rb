class LastPodcastEpisodePublisherService
  # push these to a configuration linked to an account and... this can be reused.
  PUBLISH_LIST_ORDER = %i[
    reddit
    discord
    twitter
  ].freeze

  def initialize(rss_reader = nil)
    @rss_reader = rss_reader || Rss::ReaderService.new
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
      publish_job = PublishJob.create(platform: platform, podcast_episode: episode, status: 'in_progress')
      SingleEpisodePublisherWorker.perform_async(admin_user.id, publish_job.id)
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
