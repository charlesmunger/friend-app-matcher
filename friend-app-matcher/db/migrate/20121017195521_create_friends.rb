class CreateFriends < ActiveRecord::Migration
  def change
    create_table :friends do |t|
      t.string :friend_one
      t.string :friend_two

      t.timestamps
    end
  end
end
