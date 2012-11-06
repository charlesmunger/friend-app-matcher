class Friendship < ActiveRecord::Base
  belongs_to :user, :class_name => :User
  belongs_to :friend, :class_name => :User

  attr_accessible :user_id, :friend_id, :ignore
  validates :user_id, :friend_id, presence: true
  validates_uniqueness_of :user_id, :scope => :friend_id
  validate :user_is_not_friend_to_self

  private

  def user_is_not_friend_to_self
    if (self.user_id == self.friend_id)
      errors.add(:friend_id, "cannot create a friendship to the same person")
    end
  end

end
