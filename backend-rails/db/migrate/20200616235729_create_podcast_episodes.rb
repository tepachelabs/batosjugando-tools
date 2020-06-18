class CreatePodcastEpisodes < ActiveRecord::Migration[5.2]
  def change
    create_table :podcast_episodes do |t|
      t.string :title
      t.text :description
      t.string :url
      t.string :audio_url
      t.integer :season
      t.integer :episode
      t.boolean :published, default: false

      t.timestamps
    end
  end
end
