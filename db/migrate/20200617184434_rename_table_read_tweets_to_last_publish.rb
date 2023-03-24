class RenameTableReadTweetsToLastPublish < ActiveRecord::Migration[5.2]
  def change
    rename_table :read_tweets, :last_published
  end
end
