class User < ActiveRecord::Base
  has_many :friends
  attr_accessible :auth_token, :user_id
end
