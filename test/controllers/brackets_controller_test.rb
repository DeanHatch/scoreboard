require 'test_helper'

class BracketsControllerTest < ActionController::TestCase
  setup do
    session[:manager_id] = competitions(:bball).id()
    @bracket = Bracket.find(groupings(:bballdiv1).id())
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:brackets)
  end

  test "should show bracket" do
    get :show, id: @bracket
    assert_response :success
  end
end
