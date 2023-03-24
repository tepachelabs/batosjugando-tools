class PodcastEpisode < ApplicationRecord
  has_many :publish_jobs, dependent: :destroy
end
