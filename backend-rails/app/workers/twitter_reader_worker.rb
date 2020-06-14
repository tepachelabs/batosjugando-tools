class TwitterReaderWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform
    unless BatosJugando.twitter?
      puts 'Twitter is not set-up.'
      return
    end

    puts "Hello, this is the worker for batos jugando, should run in sidekiq only."
  end

end