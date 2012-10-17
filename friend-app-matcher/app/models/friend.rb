class Friend < ActiveRecord::Base
  belongs_to :user
  attr_accessible :friend_one, :friend_two
end
