class Friend < ActiveRecord::Base
  belongs_to :user
  attr_accessible :user_id, :friend_id
  validates_uniqueness_of :user_id, :scope => :friend_id
  validate :user_is_not_friend_to_self

  private

  def user_is_not_friend_to_self
    if (self.user_id == self.friend_id)
      raise "Cannot add yourself as a friend"
    end
  end

end
