class RemoveRedditToken < ActiveRecord::Migration[5.2]
  def change
    drop_table :reddit_tokens
  end
end
