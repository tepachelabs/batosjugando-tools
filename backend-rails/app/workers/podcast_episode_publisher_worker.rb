class PodcastEpisodePublisherWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform
    PodcastEpisodePublisherService.new.call
  end
end
