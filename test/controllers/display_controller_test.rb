require 'test_helper'

class DisplayControllerTest < ActionController::TestCase
  setup do
    @competition_id = competitions(:bball).id
    @grouping_id = groupings(:bballdiv1).id
    @team_id = teams(:heat).id
  end
  
  test "should get index" do
    get :index, :competition_id => @competition_id
    assert_response :success
  end

  test "should get team" do
    get :team, :competition_id => @competition_id, :id => @team_id
    assert_response :success
  end

  test "should get grouping" do
    get :grouping, :competition_id => @competition_id, :id => @grouping_id
    assert_response :success
  end

end
