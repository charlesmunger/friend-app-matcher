class App < ActiveRecord::Base
  has_many :users
  attr_accessible :app_id, :name
end
