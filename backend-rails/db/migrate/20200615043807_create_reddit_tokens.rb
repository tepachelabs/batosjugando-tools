class CreateRedditTokens < ActiveRecord::Migration[5.2]
  def change
    create_table :reddit_tokens do |t|
      t.string :auth_token, default: ''
      t.string :refresh_token, default: ''
      t.references :admin_user, foreign_key: true

      t.timestamps
    end
  end
end
