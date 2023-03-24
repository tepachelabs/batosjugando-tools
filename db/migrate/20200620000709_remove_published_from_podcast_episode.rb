class RemovePublishedFromPodcastEpisode < ActiveRecord::Migration[5.2]
  def change
    remove_column :podcast_episodes, :published
  end
end
