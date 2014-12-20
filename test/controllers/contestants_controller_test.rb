require 'test_helper'

class ContestantsControllerTest < ActionController::TestCase
  setup do
    @contestant = contestants(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:contestants)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create contestant" do
    assert_difference('Contestant.count') do
      post :create, contestant: { bracketcontest_id: @contestant.bracketcontest_id, contest_id: @contestant.contest_id, contest_type: @contestant.contest_type, contestanttype: @contestant.contestanttype, forfeit: @contestant.forfeit, grouping_id: @contestant.grouping_id, homeaway: @contestant.homeaway, place: @contestant.place, score: @contestant.score, seeding: @contestant.seeding, team_id: @contestant.team_id }
    end

    assert_redirected_to contestant_path(assigns(:contestant))
  end

  test "should show contestant" do
    get :show, id: @contestant
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @contestant
    assert_response :success
  end

  test "should update contestant" do
    patch :update, id: @contestant, contestant: { bracketcontest_id: @contestant.bracketcontest_id, contest_id: @contestant.contest_id, contest_type: @contestant.contest_type, contestanttype: @contestant.contestanttype, forfeit: @contestant.forfeit, grouping_id: @contestant.grouping_id, homeaway: @contestant.homeaway, place: @contestant.place, score: @contestant.score, seeding: @contestant.seeding, team_id: @contestant.team_id }
    assert_redirected_to contestant_path(assigns(:contestant))
  end

  test "should destroy contestant" do
    assert_difference('Contestant.count', -1) do
      delete :destroy, id: @contestant
    end

    assert_redirected_to contestants_path
  end
end
