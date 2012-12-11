class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  devise :omniauthable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, 
  :remember_me, :uid, :provider, :username, :name
  has_many :friend_connections, :class_name => :Friendship,
                                :foreign_key => :user_id,
                                dependent: :destroy
  has_many :friends, :through => :friend_connections, 
                     :source => :friend
  has_many :user_apps

  has_many :apps, through: :user_apps, dependent: :destroy

  validates :username, presence: true, 
                       uniqueness: { case_sensitive: false }

  validates :uid, presence: true, uniqueness: true

  def self.find_for_facebook_token(token)
    graph = Koala::Facebook::API.new(token)
    profile = graph.get_object("me")
    user = User.where(:provider => :facebook, :uid => profile['id']).first
    unless user
      user = User.create(:username => profile['username'],
                         :name => profile['name'],
                         :provider => :facebook,
                         :password => Devise.friendly_token[0,20],
                         :uid => profile['id'],
                         :email => profile['email'])
      update_facebook_informations(token)
    end
  end

  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    unless user
      user = User.create(username:auth.extra.raw_info.username,
                         name:auth.extra.raw_info.name,
                         provider:auth.provider,
                         uid:auth.uid,
                         email:auth.info.email,
                         password:Devise.friendly_token[0,20])
    end
    user
  end
  
  def self.per_page
    10
  end
end
