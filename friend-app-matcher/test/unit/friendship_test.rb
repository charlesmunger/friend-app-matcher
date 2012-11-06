require 'test_helper'

class FriendshipTest < ActiveSupport::TestCase
  fixtures :users

  test "get user and friend" do
    user1 = users(:one)
    user2 = users(:two)
    friendship = Friendship.new({
      user_id: user1.id,
      friend_id: user2.id,
      ignore: false
    })

    assert_equal user1, friendship.user, 'friendship user not equal'
    assert_equal user2, friendship.friend, 'friendship friend not equal'
  end 

  # test "the truth" do
  #   assert true
  # end
end
