require 'test_helper'

class ScorerControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get record" do
    get :record
    assert_response :success
  end

  test "should get revise" do
    get :revise
    assert_response :success
  end

end
