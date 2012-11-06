class AddIgnorePropertyToFriendships < ActiveRecord::Migration
  def change
    add_column :friendships, :ignore, :boolean, :default => false
  end
end
