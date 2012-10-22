class ChangeUserAppColumnToIntegers < ActiveRecord::Migration
  def up
    change_table :user_apps do |t|
      t.change :app_id, :integer
      t.change :user_id, :integer
    end
  end

  def down
  end
end
