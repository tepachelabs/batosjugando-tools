class DeletePublishJobsWhenPodcastEpisodeIsRemoved < ActiveRecord::Migration[5.2]
  def change
    remove_foreign_key :publish_jobs, :podcast_episodes
    add_foreign_key :publish_jobs, :podcast_episodes, on_delete: :cascade
  end
end
