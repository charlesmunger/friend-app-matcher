class RemoveRoleFromApp < ActiveRecord::Migration
  def up
    remove_column :apps, :name
  end

  def down
    add_column :apps, :name, :string
  end
end
