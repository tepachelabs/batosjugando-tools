class PublishJob < ApplicationRecord
  enum status: {
         published: 'published',
         in_progress: 'in_progress',
         unpublished: 'unpublished',
         failed: 'failed'
       }, _prefix: :status

  PLATFORMS_TO_PUBLISH = %w[reddit twitter discord slack].freeze

  belongs_to :podcast_episode
  validates_uniqueness_of :podcast_episode, scope: :platform
  validates_inclusion_of :platform, in: PLATFORMS_TO_PUBLISH
end
