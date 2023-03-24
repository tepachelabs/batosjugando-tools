class AddMessageToPublishJob < ActiveRecord::Migration[5.2]
  def change
    add_column :publish_jobs, :published_url, :string, null: true
    add_column :publish_jobs, :webhook_url, :string, null: true
    add_column :publish_jobs, :message, :text, null: true
  end
end
