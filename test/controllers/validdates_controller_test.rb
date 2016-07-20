require 'test_helper'

class ValiddatesControllerTest < ActionController::TestCase
  setup do
    @validdate = validdates(:bballone)
    session[:manager_id] = competitions(:bball).id
  end

 
  test "should create validdate" do
    assert_difference('Validdate.unscoped.count') do
      post :create, validdate: { competition_id: @validdate.competition_id, gamedate: @validdate.gamedate }
    end

    assert_redirected_to venues_path
  end

end
