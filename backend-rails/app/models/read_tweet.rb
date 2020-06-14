class ReadTweet < ApplicationRecord
  validates_uniqueness_of :username
end
