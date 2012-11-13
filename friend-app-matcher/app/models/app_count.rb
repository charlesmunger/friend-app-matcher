class AppCount < ActiveRecord::Base
  attr_accessible :app_id, :count, :likes, :id

  def self.columns() @columns ||= []; end
 
  def self.column(name, sql_type = nil, default = nil, null = true)
    columns << ActiveRecord::ConnectionAdapters::Column.new(name.to_s, 
      default, sql_type.to_s, null)
  end

  column :app_id, :string
  column :count, :integer
  column :likes, :integer 
  column :id, :integer

  def self.per_page
    10
  end
end
