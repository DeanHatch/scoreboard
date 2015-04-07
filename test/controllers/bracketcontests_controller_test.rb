require 'test_helper'

class BracketcontestsControllerTest < ActionController::TestCase
  setup do
    @bracketcontest = bracketcontests(:gameone)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:bracketcontests)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create bracketcontest" do
    assert_difference('Bracketcontest.count') do
      post :create, bracketcontest: {  }
    end

    assert_redirected_to bracketcontest_path(assigns(:bracketcontest))
  end

  test "should show bracketcontest" do
    get :show, id: @bracketcontest
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @bracketcontest
    assert_response :success
  end

  test "should update bracketcontest" do
    patch :update, id: @bracketcontest, bracketcontest: {  }
    assert_redirected_to bracketcontest_path(assigns(:bracketcontest))
  end

  test "should destroy bracketcontest" do
    assert_difference('Bracketcontest.count', -1) do
      delete :destroy, id: @bracketcontest
    end

    assert_redirected_to bracketcontests_path
  end
end
