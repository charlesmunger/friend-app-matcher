require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    @input_user = {
      email: "inputtest@test.com",
      username: "Input User",
      password: "password",
      password_confirmation: "password",
      remember_me: true,
      uid: "1x1x1x1x1x1x1x1x",
      provider: "facebook",
      name: "user"
    }

    @user = users(:one)
  end

  test "show user should include apps" do
    get :show, id: @user
    assert_response :success
    assert_not_nil assigns(:user)
    assert_equal 1, assigns(:apps).length
    assert_equal @user.apps[0].id, assigns(:user).apps[0].id
    assert @page_left.nil?
    assert @page_right.nil?
  end

  test "show user should not include apps that are not installed" do
    user_app = user_apps(:one)
    user_app.installed = false
    user_app.save
    get :show, id: @user
    assert_response :success
    assert_not_nil assigns(:user)
    assert_equal 0, assigns(:apps).length
    assert @page_left.nil?
    assert @page_right.nil?
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
    put :update, id: @user, user: @input_user
    assert_redirected_to user_path(assigns(:user))
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete :destroy, id: @user
    end

    assert_redirected_to new_user_session_path
  end
end
