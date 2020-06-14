schedule_file = "config/schedule.yml"

if File.exist?(schedule_file) #&& Rails.env.production?
  Sidekiq::Cron::Job.load_from_hash YAML.load_file(schedule_file)
end