class AddStatusToPublishJob < ActiveRecord::Migration[5.2]
  def up
    execute <<-SQL
      CREATE TYPE published_job_status AS ENUM ('published', 'unpublished', 'in_progress', 'failed');
    SQL
    add_column :publish_jobs, :status, :published_job_status, default: :unpublished
    add_index :publish_jobs, %i[podcast_episode_id platform], unique: true
    add_index :publish_jobs, :status
  end

  def down
    remove_column :publish_jobs, :status
    execute <<-SQL
      DROP TYPE published_job_status;
    SQL
  end
end
