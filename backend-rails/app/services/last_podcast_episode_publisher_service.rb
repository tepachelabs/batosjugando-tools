class LastPodcastEpisodePublisherService
  # push these to a configuration linked to an account and... this can be reused.
  PUBLISH_LIST_ORDER = %i[
    reddit
    discord
    twitter
  ].freeze

  def initialize(synch_service = nil)
    @synch_service = synch_service || PodcastEpisodeSynchService.new
  end

  def call
    episodes = @synch_service.call

    return if episodes.empty?

    publish(AdminUser.first, episodes.first)
  end

  private

  def publish(admin_user, episode)
    PUBLISH_LIST_ORDER.each do |platform|
      publish_job = PublishJob.create(platform: platform, podcast_episode: episode, status: 'in_progress')
      SingleEpisodePublisherWorker.perform_async(admin_user.id, publish_job.id)
    end
  end
end
