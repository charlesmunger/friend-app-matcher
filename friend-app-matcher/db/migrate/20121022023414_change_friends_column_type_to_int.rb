class ChangeFriendsColumnTypeToInt < ActiveRecord::Migration
  def up
    change_table :friends do |t|
      t.change :user_id, :integer
      t.change :friend_id, :integer
    end
  end

  def down
  end
end
