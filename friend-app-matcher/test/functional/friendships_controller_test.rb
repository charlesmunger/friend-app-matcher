require 'test_helper'

class FriendshipsControllerTest < ActionController::TestCase
  setup do
    @user1 = users(:one)
    @user3 = users(:three)
    @input_friendship = {
      user_id: @user1.username,
      friend_id: @user3.username,
      ignore: false
    }

    @friendship = friendships(:one)    
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:friends)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create friendship" do
    assert_difference('Friendship.count') do
      post :create, friendship: @input_friendship
    end

    assert_redirected_to friendships_path
    assert_not_nil assigns(:friendship)
  end

  test "should show friendship" do
    get :show
    assert_redirected_to friendships_index_path
  end

  test "should get edit" do
    get :edit, id: @friendship
    assert_response :success
  end

  test "should update friendship" do
    put :update, id: @friendship, friendship: { user_id: @friendship.user_id, friend_id: @friendship.friend_id }
    assert_response :success
  end

  test "should destroy friendship" do
    assert_difference('Friendship.count', -1) do
      delete :destroy, id: @friendship
    end

    assert_redirected_to friendships_path
  end

  test "should ignore friendship" do
    put :update, id: @friendship, ignore: "true"
    
    assert_response :success

    result = assigns(:friendship)
    assert result.ignore
  end
end
