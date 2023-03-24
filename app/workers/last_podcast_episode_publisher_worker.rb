class LastPodcastEpisodePublisherWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform
    LastPodcastEpisodePublisher.new.call
  end
end
