puts("Hello from sidekiq")
Sidekiq.configure_server do |config|
  config.redis = {
    url: ENV.fetch("REDIS_HOST", 'redis://localhost:6379'),
    password: ENV.fetch("REDIS_PASSWORD", 'password')
  }

  config.on(:startup) do
    schedule_file = "config/users_schedule.yml"

    if File.exist?(schedule_file)
      Sidekiq::Cron::Job.load_from_hash YAML.load_file(schedule_file)
    end
  end
end