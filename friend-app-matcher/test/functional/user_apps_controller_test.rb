require 'test_helper'

class UserAppsControllerTest < ActionController::TestCase
  setup do
    @user = users(:one)
    @app1 = apps(:one)
    @app2 = apps(:two)

    # Third app hasn't been added to db yet
    @app3_package_name = "com.text.app3"
    @input_user_app = {
      uid: @user.uid,
      apps: @app2.app_id + "\n" + @app3_package_name + "\n" + @app1.app_id
    }

    @user_app = user_apps(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:user_apps)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user_apps" do
    assert_difference('UserApp.count', 2) do
      post :create, user_app: @input_user_app
    end

    assert_redirected_to user_apps_path
    assert_not_nil assigns(:user)
    assert_not_nil assigns(:apps)
    assert_not_nil assigns(:user_apps)
  end

  test "create updates user_app when already present" do
    user_app = UserApp.new({ user_id: @user.id, app_id: 
              @app2.id, liked: true })
    user_app.save
    post :create, user_app: @input_user_app
    
    updated_app = UserApp.where(:user_id => @user.id, :app_id => @app2.id)[0]
    assert updated_app.installed
    assert updated_app.liked
    
    updated_app = UserApp.where(:user_id => @user.id, :app_id => @app1.id)[0]
    assert updated_app.installed
    assert !updated_app.liked
  end

  test "should show user_app" do
    get :show, id: @user_app
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user_app
    assert_response :success
  end

  test "should update user_app" do
    put :update, id: @user_app, user_app: { app_id: @user_app.app_id, user_id: @user_app.user_id }
    assert_redirected_to user_app_path(assigns(:user_app))
  end

  test "should destroy user_app" do
    assert_difference('UserApp.count', -1) do
      delete :destroy, id: @user_app
    end

    assert_redirected_to user_apps_path
  end

  test "should not create user_app invalid username" do
    bad_input = {
      uid: "Unknown",
      apps: ""
    }

    assert_difference('UserApp.count', 0) do
      post :create, user_app: bad_input
    end

    assert_redirected_to user_apps_path
    assert_nil assigns(:user)
  end
end
