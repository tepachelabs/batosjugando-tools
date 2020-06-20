class LastPodcastEpisodePublisherWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform
    LastPodcastEpisodePublisherService.new.call
  end
end
