class UpdateLastPublishedColumns < ActiveRecord::Migration[5.2]
  def change
    remove_index :last_published, :username

    change_table(:last_published) do |t|
      t.rename(:username, :twitter_username)
      t.column(:name, :string)
      t.column(:podcast_episode_url, :string)
    end

    add_index :last_published, :twitter_username, unique: true
    add_index :last_published, :podcast_episode_url, unique: true
  end
end
