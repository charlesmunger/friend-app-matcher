class CreateUserApps < ActiveRecord::Migration
  def change
    create_table :user_apps do |t|
      t.string :user_id
      t.string :app_id

      t.timestamps
    end
  end
end
