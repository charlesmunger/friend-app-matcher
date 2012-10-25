require 'test_helper'

class RecommendationsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "get index returns friends apps" do
    get :index
    assert_response :success
    app_counts = assigns(:appCounts)
    assert_not_nil app_counts
    assert_equal 1, app_counts.length
    friends_app = app_counts[0]
    assert_equal apps(:two), friends_app[0]
    assert_equal 1, friends_app[1]
  end

end
