class User < ActiveRecord::Base
  attr_accessible :auth_token, :user_id
end
