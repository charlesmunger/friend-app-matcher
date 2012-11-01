class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  has_many :friend_connections, :class_name => :Friendship,
                                :foreign_key => :user_id,
                                dependent: :destroy
  has_many :friends, :through => :friend_connections, 
                     :source => :friend
  has_many :user_apps

  has_many :apps, through: :user_apps, dependent: :destroy

  attr_accessible :uid, :provider, :username

  validates :username, presence: true, 
                       uniqueness: { case_sensitive: false }

  def self.per_page
    10
  end
end
