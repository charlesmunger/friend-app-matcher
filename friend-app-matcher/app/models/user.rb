class User < ActiveRecord::Base
  has_many :friends, dependent: :destroy
  has_many :user_apps

  attr_accessible :auth_token, :user_id

  validates :user_id, presence: true, 
                      uniqueness: { case_sensitive: false }
end
