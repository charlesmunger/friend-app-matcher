class App < ActiveRecord::Base
  has_many :user_apps
  attr_accessible :app_id, :name

  validates :app_id, presence: true, uniqueness: true
end
