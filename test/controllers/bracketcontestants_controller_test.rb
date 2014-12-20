require 'test_helper'

class BracketcontestantsControllerTest < ActionController::TestCase
  setup do
    @bracketcontestant = bracketcontestants(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:bracketcontestants)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create bracketcontestant" do
    assert_difference('Bracketcontestant.count') do
      post :create, bracketcontestant: { contest_id: @bracketcontestant.contest_id, contest_type: @bracketcontestant.contest_type, contestanttype: @bracketcontestant.contestanttype, forfeit: @bracketcontestant.forfeit, homeaway: @bracketcontestant.homeaway, score: @bracketcontestant.score, seeding: @bracketcontestant.seeding, team_id: @bracketcontestant.team_id }
    end

    assert_redirected_to bracketcontestant_path(assigns(:bracketcontestant))
  end

  test "should show bracketcontestant" do
    get :show, id: @bracketcontestant
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @bracketcontestant
    assert_response :success
  end

  test "should update bracketcontestant" do
    patch :update, id: @bracketcontestant, bracketcontestant: { contest_id: @bracketcontestant.contest_id, contest_type: @bracketcontestant.contest_type, contestanttype: @bracketcontestant.contestanttype, forfeit: @bracketcontestant.forfeit, homeaway: @bracketcontestant.homeaway, score: @bracketcontestant.score, seeding: @bracketcontestant.seeding, team_id: @bracketcontestant.team_id }
    assert_redirected_to bracketcontestant_path(assigns(:bracketcontestant))
  end

  test "should destroy bracketcontestant" do
    assert_difference('Bracketcontestant.count', -1) do
      delete :destroy, id: @bracketcontestant
    end

    assert_redirected_to bracketcontestants_path
  end
end
