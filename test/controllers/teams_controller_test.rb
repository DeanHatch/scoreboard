require 'test_helper'

class TeamsControllerTest < ActionController::TestCase
  setup do
    @team = teams(:heat)
    @grouping = groupings(:bballcon11)
    session[:manager_id] = competitions(:bball).id()
  end

  test "should get index" do
    get :index, grouping_id: @grouping.id
    assert_response :success
    assert_not_nil assigns(:teams)
  end

  test "should get new" do
    get :new, grouping_id: @grouping.id
    assert_response :success
  end

  test "should create team" do
    assert_difference('Team.unscoped.count') do
      post :create, grouping_id: @grouping.id, team: { competition_id: @team.competition_id, grouping_id: @team.grouping_id, name: @team.name }
    end

    assert_redirected_to grouping_teams_path # (assigns(:team))
  end

  test "should show team" do
    get :show, id: @team
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @team
    assert_response :success
  end

  test "should update team" do
    patch :update, id: @team, grouping_id: @team.grouping_id,
	team: { competition_id: @team.competition_id, grouping_id: @team.grouping_id, name: @team.name }
    assert_response :redirect
    assert_redirected_to ({action: :index, grouping_id: @team.grouping_id })
  end

  test "should destroy team" do
    assert_difference('Team.count', -1) do
      delete :destroy, id: @team, grouping_id: @team.grouping_id
    end

    assert_response :redirect
    assert_redirected_to ({action: :index, grouping_id: @team.grouping_id })
  end
end
