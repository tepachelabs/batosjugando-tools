module BatosJugando
  def self.sentry?
    ENV['BJ_RAVEN_DNS'].present?
  end
end

if BatosJugando.sentry?
  Raven.configure do |config|
    config.dsn = ENV['BJ_RAVEN_DNS']
  end

  puts 'Raven setup complete'
end
