class User < ActiveRecord::Base
  has_many :friends
  has_many :apps
  attr_accessible :auth_token, :user_id
end
