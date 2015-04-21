require 'test_helper'

class GroupingsControllerTest < ActionController::TestCase
  setup do
    @grouping = groupings(:bballdiv1)
    session[:manager_id] = competitions(:bball).id()
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:groupings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create grouping" do
	# Note that the count must be on the unscoped model
	# because that is what will be counted before the #create method
    assert_difference('Grouping.unscoped.count') do
      post :create, grouping: { competition_id: @grouping.competition_id,
	name: "Something New", parent_id: @grouping.parent_id }
    end

    assert_redirected_to groupings_path # (assigns(:grouping))
  end

  test "should show grouping" do
    get :show, id: @grouping
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @grouping
    assert_response :success
  end

  test "should update grouping" do
    patch :update, id: @grouping, grouping: { competition_id: @grouping.competition_id,
	name: @grouping.name, parent_id: @grouping.parent_id }
    assert_redirected_to groupings_path # (assigns(:grouping))
  end

  test "should destroy grouping" do
    assert_difference('Grouping.count', -1) do
      delete :destroy, id: @grouping
    end

    assert_redirected_to groupings_path
  end
end
