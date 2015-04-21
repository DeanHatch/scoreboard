require 'test_helper'

class ValiddatesControllerTest < ActionController::TestCase
  setup do
    @validdate = validdates(:bballone)
    session[:manager_id] = competitions(:bball).id
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:validdates)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create validdate" do
    assert_difference('Validdate.unscoped.count') do
      post :create, validdate: { competition_id: @validdate.competition_id, gamedate: @validdate.gamedate }
    end

    assert_redirected_to venues_path
  end

  test "should show validdate" do
    get :show, id: @validdate
    assert_response :success
    #assert_redirected_to venues_path
  end

  test "should get edit" do
    get :edit, id: @validdate
    assert_response :success
  end

  test "should update validdate" do
    patch :update, id: @validdate, validdate: { competition_id: @validdate.competition_id, gamedate: @validdate.gamedate }
    assert_redirected_to venues_path
  end

  test "should destroy validdate" do
    assert_difference('Validdate.count', -1) do
      delete :destroy, id: @validdate
    end

    assert_redirected_to venues_path
  end
end
