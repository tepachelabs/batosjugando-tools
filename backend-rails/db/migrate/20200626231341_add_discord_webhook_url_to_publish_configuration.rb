class AddDiscordWebhookUrlToPublishConfiguration < ActiveRecord::Migration[5.2]
  def change
    add_column :publish_configurations, :discord_webhook_url, :string, null: true
    remove_column :publish_jobs, :webhook_url
  end
end
