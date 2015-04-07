require 'test_helper'

class BracketsControllerTest < ActionController::TestCase
  setup do
    #@bracket = brackets(:one)
    @bracket = groupings(:bballdiv1)
  end

  test "should get index" do
    get :index
    assert_response :redirect
    assert_not_nil assigns(:brackets)
  end

  test "should show bracket" do
    get :show, id: @bracket
    assert_response :redirect
  end
end
