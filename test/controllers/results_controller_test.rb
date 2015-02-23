require 'test_helper'

class ResultsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get rescord" do
    get :rescord
    assert_response :success
  end

  test "should get scorect" do
    get :scorect
    assert_response :success
  end

end
