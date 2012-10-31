class User < ActiveRecord::Base
  has_many :friend_connections, :class_name => :Friendship,
                                :foreign_key => :user_id,
                                dependent: :destroy
  has_many :friends, :through => :friend_connections, 
                     :source => :friend
  has_many :user_apps

  has_many :apps, through: :user_apps, dependent: :destroy

  attr_accessible :auth_token, :username

  validates :username, presence: true, 
                       uniqueness: { case_sensitive: false }

  def self.per_page
    10
  end
end
