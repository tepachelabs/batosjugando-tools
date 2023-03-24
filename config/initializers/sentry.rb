module BatosJugando
  def self.sentry?
    ENV['BJ_RAVEN_DNS'].present? && Rails.env.production?
  end
end

if BatosJugando.sentry?
  Sentry.init do |config|
    config.dsn = ENV.fetch('BJ_RAVEN_DNS', nil)
  end

  puts 'Sentry setup complete'
end
