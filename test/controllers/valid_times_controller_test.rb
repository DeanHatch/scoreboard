require 'test_helper'

class ValidTimesControllerTest < ActionController::TestCase
  setup do
    @valid_time = valid_times(:one)
	 org = organizations(:countyrec)
	 org.save!
	 competition = competitions(:bball)
	 competition.organization_id = org.id
	 competition.save!
	 @org_id = org.id
	 @comp_id = competition.id
	 session[:manager_id] = @comp_id
  end

  test "should get index" do
    get :index
    assert_response :success
    #assert_not_nil assigns(:valid_times)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create valid_time" do
    assert_difference('ValidTime.unscoped.count') do
      post :create, valid_time: { competition_id: @valid_time.competition_id,
           from_time: 3,
           to_time: 3 }
    end

    assert_redirected_to valid_times_path()
  end

  test "should show valid_time" do
    get :show, id: @valid_time
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @valid_time
    assert_response :success
  end

  test "should update valid_time" do
    patch :update, id: @valid_time.id, valid_time: { competition_id: @valid_time.competition_id, from_time: @valid_time.from_time, grouping_id: @valid_time.grouping_id, to_time: @valid_time.to_time, venue_id: @valid_time.venue_id }
    assert_redirected_to valid_times_path()
  end

  test "should destroy valid_time" do
    assert_difference('ValidTime.count', -1) do
      delete :destroy, id: @valid_time
    end

    assert_redirected_to valid_times_path
  end
end
