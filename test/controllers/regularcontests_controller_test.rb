require 'test_helper'

class RegularcontestsControllerTest < ActionController::TestCase
  setup do
      # Remember that there are no Regularcontest fixtures
      # so we get our Regularcontests from the Contests fixtures.
      # This is a testing consequence of Single Table Inheritance.
    @regularcontest = contests(:rcgameone)
    session[:manager_id] = competitions(:bball).id()
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:regularcontests)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create regularcontest" do
    assert_difference('Regularcontest.count') do
      post :create, regularcontest: { status: "SCHEDULED" }
    end

    assert_redirected_to regularcontests_path # (assigns(:regularcontest))
  end

  test "should show regularcontest" do
    get :show, id: @regularcontest
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @regularcontest
    assert_response :success
  end

  test "should update regularcontest" do
    patch :update, id: @regularcontest, regularcontest: {  status: "SCHEDULED" }
    assert_redirected_to regularcontests_path # (assigns(:regularcontest))
  end

  test "should destroy regularcontest" do
    assert_difference('Regularcontest.count', -1) do
      delete :destroy, id: @regularcontest
    end

    assert_redirected_to regularcontests_path
  end
end
