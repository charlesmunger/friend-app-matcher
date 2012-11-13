class AddLikedToUserApps < ActiveRecord::Migration
  def change
    add_column :user_apps, :liked, :boolean, :default => false
  end
end
