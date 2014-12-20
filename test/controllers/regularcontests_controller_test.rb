require 'test_helper'

class RegularcontestsControllerTest < ActionController::TestCase
  setup do
    @regularcontest = regularcontests(:one)
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
      post :create, regularcontest: {  }
    end

    assert_redirected_to regularcontest_path(assigns(:regularcontest))
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
    patch :update, id: @regularcontest, regularcontest: {  }
    assert_redirected_to regularcontest_path(assigns(:regularcontest))
  end

  test "should destroy regularcontest" do
    assert_difference('Regularcontest.count', -1) do
      delete :destroy, id: @regularcontest
    end

    assert_redirected_to regularcontests_path
  end
end
