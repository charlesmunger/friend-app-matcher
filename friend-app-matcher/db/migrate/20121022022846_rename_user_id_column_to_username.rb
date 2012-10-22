class RenameUserIdColumnToUsername < ActiveRecord::Migration
  def up
    rename_column :users, :user_id, :username
  end

  def down
  end
end
