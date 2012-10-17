class UserApp < ActiveRecord::Base
  belongs_to :user
  belongs_to :app
  attr_accessible :app_id, :user_id
end
