module BatosJugando
  def self.sentry?
    ENV['BJ_RAVEN_DNS'].present? && Rails.env.production?
  end
end

if BatosJugando.sentry?
  Sentry.configure do |config|
    config.dsn = ENV['BJ_RAVEN_DNS']
  end

  puts 'Sentry setup complete'
end
