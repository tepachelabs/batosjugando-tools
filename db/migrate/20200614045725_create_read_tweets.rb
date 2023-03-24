class CreateReadTweets < ActiveRecord::Migration[5.2]
  def change
    create_table :read_tweets do |t|
      t.string :username
      t.string :last_tweet_id, unique: true

      t.timestamps
    end

    add_index :read_tweets, :username, unique: true
  end
end
