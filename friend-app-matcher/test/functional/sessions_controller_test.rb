require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  test "should get new" do
    get :new
    assert_response :success
  end

  test "should login" do
    user = users(:one)
    post :create, username: user.user_id
    assert_redirected_to users_url + '/' + user.id.to_s
    assert_equal user.user_id, session[:user_id]
  end

  test "should logout" do
    delete :destroy
    assert_redirected_to login_url
  end
end
