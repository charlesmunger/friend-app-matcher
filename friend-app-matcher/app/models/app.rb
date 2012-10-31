class App < ActiveRecord::Base
  has_many :user_apps
  attr_accessible :app_id, :name

  # app_id is the Android App package name
  # Name is the string that appears on the Android Market
  validates :app_id, presence: true, uniqueness: true

  def self.per_page
    10
  end
end
