class AdminUser < ApplicationRecord
  has_one :reddit_token # TODO: remove me
  has_one :publish_configuration

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable
end
