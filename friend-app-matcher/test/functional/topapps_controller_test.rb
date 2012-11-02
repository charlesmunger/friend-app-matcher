require 'test_helper'

class TopappsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "get index returns all apps" do
    get :index
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
