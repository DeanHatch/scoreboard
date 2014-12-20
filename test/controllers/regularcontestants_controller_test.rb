require 'test_helper'

class RegularcontestantsControllerTest < ActionController::TestCase
  setup do
    @regularcontestant = regularcontestants(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:regularcontestants)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create regularcontestant" do
    assert_difference('Regularcontestant.count') do
      post :create, regularcontestant: { contest_id: @regularcontestant.contest_id, contest_type: @regularcontestant.contest_type, forfeit: @regularcontestant.forfeit, homeaway: @regularcontestant.homeaway, score: @regularcontestant.score, team_id: @regularcontestant.team_id }
    end

    assert_redirected_to regularcontestant_path(assigns(:regularcontestant))
  end

  test "should show regularcontestant" do
    get :show, id: @regularcontestant
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @regularcontestant
    assert_response :success
  end

  test "should update regularcontestant" do
    patch :update, id: @regularcontestant, regularcontestant: { contest_id: @regularcontestant.contest_id, contest_type: @regularcontestant.contest_type, forfeit: @regularcontestant.forfeit, homeaway: @regularcontestant.homeaway, score: @regularcontestant.score, team_id: @regularcontestant.team_id }
    assert_redirected_to regularcontestant_path(assigns(:regularcontestant))
  end

  test "should destroy regularcontestant" do
    assert_difference('Regularcontestant.count', -1) do
      delete :destroy, id: @regularcontestant
    end

    assert_redirected_to regularcontestants_path
  end
end
