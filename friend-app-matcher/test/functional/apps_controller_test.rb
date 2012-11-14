require 'test_helper'

class AppsControllerTest < ActionController::TestCase
  setup do
    @input_app = {
      app_id: "Input App",
    }

    @app = apps(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:apps)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create app" do
    assert_difference('App.count') do
      post :create, app: @input_app
    end

    assert_redirected_to app_path(assigns(:app))
  end

  test "should show app" do
    get :show, id: @app
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @app
    assert_response :success
  end

  test "should update app" do
    put :update, id: @app, app: { app_id: @app.app_id}
    assert_redirected_to app_path(assigns(:app))
  end

  test "should destroy app" do
    assert_difference('App.count', -1) do
      delete :destroy, id: @app
    end

    assert_redirected_to apps_path
  end

  test "like and unlike app" do
    @user = users(:one)
    xhr :put, :like, id: @app.id
    assert_response :success
    assert_equal 1, App.find(@app.id).likes
    user_app = UserApp.where(:user_id => @user.id, :app_id => @app.id)[0]
    assert user_app.liked

    xhr :put, :like, id: @app.id
    assert_response :success
    assert_equal 0, App.find(@app.id).likes
    user_app = UserApp.where(:user_id => @user.id, :app_id => @app.id)[0]
    assert !user_app.liked
  end

  test "like app when user_app doesn't exist" do
    @app = apps(:two)
    @user = users(:one)
    xhr :put, :like, id: @app.id
    assert_response :success
    assert_equal 1, App.find(@app.id).likes
    user_app = UserApp.where(:user_id => @user.id, :app_id => @app.id)[0]
    assert user_app.liked
    assert !user_app.installed
  end

  test "get recommendations returns friends apps" do
    get :recommendations
    assert_response :success
    app_counts = assigns(:app_counts)
    assert_not_nil app_counts
    assert_equal 1, app_counts.length
    friends_app = app_counts.keys[0]
    assert_equal apps(:two), friends_app
    assert_equal 1, app_counts[friends_app]
  end

  test "do not recommend apps already installed by user" do
    UserApp.new({ user_id: users(:one).id, app_id: apps(:two).id }).save
    get :recommendations
    assert_response :success
    app_counts = assigns(:app_counts)
    assert_not_nil app_counts
    assert_equal 0, app_counts.length
  end

  test "do not recommend apps from ignored friends" do
    user = users(:one)
    UserApp.new({ user_id: users(:two).id, app_id: apps(:two).id }).save
    UserApp.new({ user_id: users(:three).id, app_id: apps(:two).id }).save
    Friendship.new({ user_id: user.id, friend_id: users(:two).id,
                     ignore: false }).save
    Friendship.new({ user_id: user.id, friend_id: users(:three).id,
                     ignore: true }).save

    get :recommendations
    assert_response :success
    app_counts = assigns(:app_counts)
    assert_not_nil app_counts
    assert_equal 1, app_counts.length
  end

  test "get top appss" do
    get :topapps
    assert_response :success
    app_counts = assigns(:app_counts)
    assert_not_nil app_counts
    assert_equal 2, app_counts.length
    app_counts.each do |app_count|
      assert_equal 1, app_count.count
    end
    assert @page_left.nil?
    assert @page_right.nil?
  end

end
