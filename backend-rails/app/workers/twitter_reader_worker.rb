class TwitterReaderWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform
    unless BatosJugando.twitter?
      puts 'Twitter is not set-up, woops!'
      return
    end

    TwitterReaderService.new.call
  end
end
