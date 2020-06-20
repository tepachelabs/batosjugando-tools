class CreatePublishJobs < ActiveRecord::Migration[5.2]
  def change
    create_table :publish_jobs do |t|
      t.references :podcast_episode, foreign_key: true
      t.string :platform

      t.timestamps
    end
  end
end
