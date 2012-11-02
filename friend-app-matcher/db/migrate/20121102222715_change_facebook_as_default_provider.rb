class ChangeFacebookAsDefaultProvider < ActiveRecord::Migration
  def up
    change_column_default :users, :provider, :facebook
  end

  def down
    change_column :users, :provider, :string, :default => nil
  end
end
