class ManualEpisodePublisherWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(user_id, publish_job_id)
    puts "Called with: { user_id: #{user_id}, publish_job_id: #{publish_job_id} }"
    user = AdminUser.find(user_id)
    publish_job = PublishJob.find(publish_job_id)
    PodcastEpisodePublisherService.new.call(user, publish_job)
  end
end
