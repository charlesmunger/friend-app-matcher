class RenameFriendColumns < ActiveRecord::Migration
  def up
    rename_column :friends, :friend_one, :user_id
    rename_column :friends, :friend_two, :friend_id
  end

  def down
  end
end
