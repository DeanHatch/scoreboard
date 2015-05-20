require 'test_helper'

class BracketgroupingsControllerTest < ActionController::TestCase
  setup do
    session[:manager_id] = competitions(:bball).id()
    @bracketgrouping = Bracketgrouping.find(groupings(:bballdiv1).id())
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:bracketgroupings)
  end

  test "should show bracketgrouping" do
    get :show, id: @bracketgrouping
    assert_response :success
  end
end
