require 'test_helper'

class ValidTimesControllerTest < ActionController::TestCase
  setup do
    @valid_time = valid_times(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:valid_times)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create valid_time" do
    assert_difference('ValidTime.count') do
      post :create, valid_time: { competition_id: @valid_time.competition_id, from_time: @valid_time.from_time, grouping_id: @valid_time.grouping_id, to_time: @valid_time.to_time, venue_id: @valid_time.venue_id }
    end

    assert_redirected_to valid_time_path(assigns(:valid_time))
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
    patch :update, id: @valid_time, valid_time: { competition_id: @valid_time.competition_id, from_time: @valid_time.from_time, grouping_id: @valid_time.grouping_id, to_time: @valid_time.to_time, venue_id: @valid_time.venue_id }
    assert_redirected_to valid_time_path(assigns(:valid_time))
  end

  test "should destroy valid_time" do
    assert_difference('ValidTime.count', -1) do
      delete :destroy, id: @valid_time
    end

    assert_redirected_to valid_times_path
  end
end
