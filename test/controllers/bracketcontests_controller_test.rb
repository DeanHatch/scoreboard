require 'test_helper'

class BracketcontestsControllerTest < ActionController::TestCase
  setup do
    session[:manager_id] = competitions(:bball).id()
    @bracketgrouping = Bracketgrouping.find(groupings(:bballdiv1).id()) # cannot use groupings fixtures
    @bracketcontest = contests(:bcgameone)
  end

  test "should get new" do
    get :new, bracketgrouping_id: @bracketgrouping.id
    assert_response :success
  end

  test "should create bracketcontest" do
    assert_difference('Bracketcontest.count') do
      post :create,   bracketgrouping_id: @bracketgrouping.id,
        bracketcontest: { status: "SCHEDULED" }, 
	homecontestant: {contestantcode: "G" + @bracketgrouping.id.to_s + "P1" }, 
	awaycontestant: {contestantcode: "G" + @bracketgrouping.id.to_s + "P2" }
    puts flash[:alert] + " (" + @bracketgrouping.id.to_s + ")" if flash[:alert]
    end

    # should edit the newly created Bracketcontest
    assert_redirected_to(:action => "edit", :id => assigns(:bracketcontest))
  end

  test "should show bracketcontest" do
    get :show, id: @bracketcontest.id, bracketgrouping_id: @bracketgrouping.id
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @bracketcontest, bracketgrouping_id: @bracketgrouping.id
    assert_response :success
  end

  test "should update bracketcontest" do
    patch :update, id: @bracketcontest, bracketgrouping_id: @bracketgrouping.id,
        bracketcontest: { status: "SCHEDULED" }, 
	homecontestant: {contestantcode: @bracketgrouping.all_participant_codes().first() }, 
	awaycontestant: {contestantcode: @bracketgrouping.all_participant_codes().first() }
    assert_redirected_to bracketgrouping_bracketcontest_path # (assigns(:bracketcontest))
  end

end
