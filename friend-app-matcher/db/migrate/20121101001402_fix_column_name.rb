class FixColumnName < ActiveRecord::Migration

  def change
    rename_column :users, :auth_token, :uid
  end
end
