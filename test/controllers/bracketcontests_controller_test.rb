require 'test_helper'

class BracketcontestsControllerTest < ActionController::TestCase
  setup do
    session[:manager_id] = competitions(:bball).id()
    @bracket = Bracket.find(groupings(:bballdiv1).id()) # cannot use groupings fixtures
    @bracketcontest = contests(:bcgameone)
  end

  test "should get index" do
    p Bracket.all.size()
    p Bracketcontest.all.size()
    get :index, bracket_id: @bracket.id
    assert_response :success
    assert_not_nil assigns(:bracketcontests)
  end

  test "should get new" do
    get :new, bracket_id: @bracket.id
    assert_response :success
  end

  test "should create bracketcontest" do
    assert_difference('Bracketcontest.count') do
      post :create,   bracket_id: @bracket.id,
        bracketcontest: { status: "SCHEDULED" }, 
	homecontestant: {contestantcode: @bracket.all_participant_codes().first() }, 
	awaycontestant: {contestantcode: @bracket.all_participant_codes().first() }
    end

    # should edit the newly created Bracketcontest
    assert_redirected_to(:action => "edit", :id => assigns(:bracketcontest))
  end

  test "should show bracketcontest" do
    get :show, id: @bracketcontest.id, bracket_id: @bracket.id
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @bracketcontest, bracket_id: @bracket.id
    assert_response :success
  end

  test "should update bracketcontest" do
    patch :update, id: @bracketcontest, bracket_id: @bracket.id,
        bracketcontest: { status: "SCHEDULED" }, 
	homecontestant: {contestantcode: @bracket.all_participant_codes().first() }, 
	awaycontestant: {contestantcode: @bracket.all_participant_codes().first() }
    assert_redirected_to bracket_bracketcontest_path # (assigns(:bracketcontest))
  end

  test "should destroy bracketcontest" do
    assert_difference('Bracketcontest.count', -1) do
      delete :destroy, id: @bracketcontest, bracket_id: @bracket.id 
    end

    assert_redirected_to bracket_bracketcontests_path
  end
end
