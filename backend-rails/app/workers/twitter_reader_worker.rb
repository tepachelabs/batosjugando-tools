class TwitterReaderWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform
    raise 'Twitter is not set-up, woops!' unless BatosJugando.twitter?

    TwitterReaderService.new.call
  end
end
