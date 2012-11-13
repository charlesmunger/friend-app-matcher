class AddLikesToApps < ActiveRecord::Migration
  def change
    add_column :apps, :likes, :integer, :default => 0
  end
end
