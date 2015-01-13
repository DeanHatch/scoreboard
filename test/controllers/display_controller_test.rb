require 'test_helper'

class DisplayControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get team" do
    get :team
    assert_response :success
  end

  test "should get grouping" do
    get :grouping
    assert_response :success
  end

end
