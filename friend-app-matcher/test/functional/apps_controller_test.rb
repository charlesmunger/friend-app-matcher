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
end
