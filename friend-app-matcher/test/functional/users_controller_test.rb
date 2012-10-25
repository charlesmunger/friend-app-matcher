require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    @input_user = {
      username: "Input User",
      auth_token: "Input User Token"
    }

    @user = users(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:users)
  end

  test "show user should include apps" do
    get :show, id: @user
    assert_response :success
    assert_not_nil assigns(:user)
    assert_equal 1, assigns(:user).apps.count
    assert_equal @user.apps[0].id, assigns(:user).apps[0].id
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user" do
    assert_difference('User.count') do
      post :create, user: @input_user
    end

    assert_redirected_to user_path(assigns(:user))
  end

  test "should show user" do
    get :show, id: @user
    assert_response :success
  end

  test "shouldn't show user if not friends" do
    get :show, id: users(:three)
    assert_response :redirect
  end

  test "should get edit" do
    get :edit, id: @user
    assert_response :success
  end

  test "should update user" do
    put :update, id: @user, user: { auth_token: @user.auth_token, 
                                    username: @user.username }
    assert_redirected_to user_path(assigns(:user))
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete :destroy, id: @user
    end

    assert_redirected_to users_path
  end
end
