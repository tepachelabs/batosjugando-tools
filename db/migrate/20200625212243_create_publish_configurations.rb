class CreatePublishConfigurations < ActiveRecord::Migration[5.2]
  def change
    create_table :publish_configurations do |t|
      t.string :reddit_token
      t.string :reddit_refresh_token
      t.string :twitter_oauth_token
      t.string :twitter_oauth_token_secret
      t.references :admin_user, foreign_key: true

      t.timestamps
    end
  end
end
