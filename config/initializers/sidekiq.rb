schedule_file = 'config/schedule.yml'

if Rails.env.production?
  Sidekiq.configure_client do |config|
    config.redis = {
      url: ENV.fetch("REDIS_HOST", 'redis://localhost:6379'),
      password: ENV.fetch("REDIS_PASSWORD", 'password')
    }
  end
end

Sidekiq::Cron::Job.load_from_hash YAML.load_file(schedule_file) if File.exist?(schedule_file) && Rails.env.production?
