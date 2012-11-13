class AddInstalledToUserApps < ActiveRecord::Migration
  def change
    add_column :user_apps, :installed, :boolean, :default => false
  end
end
