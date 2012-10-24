class User < ActiveRecord::Base
  has_many :friend_connections, :class_name => :Friend,
                                :foreign_key => :user_id,
                                dependent: :destroy
  has_many :friends, :through => :friend_connections, 
                     :source => :friend
  has_many :user_apps

  has_many :apps, through: :user_apps

  attr_accessible :auth_token, :username

  validates :username, presence: true, 
                       uniqueness: { case_sensitive: false }
end
