class LastPublished < ApplicationRecord
  self.table_name = 'last_published'
  validates_uniqueness_of :twitter_username
  validates_uniqueness_of :podcast_episode_url
end
