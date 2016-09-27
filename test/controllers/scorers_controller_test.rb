require 'test_helper'

class ScorersControllerTest < ActionController::TestCase

  setup do
	   # Organization must exist for Competition foreign key.
	   # Manager inherits from Competition.
	   # Steps are:
	   #  1) Load Organization
	   #  2) Load Competition
	   #  3) Log Manager in to that Competition
	 #~ org = organizations(:alwaysright)
	 #~ org.save!
	 #~ competition = competitions(:soccer)
	 #~ competition.organization_id = org.id
	 #~ competition.save!
	 org = organizations(:countyrec)
	 org.save!
	 competition = competitions(:bball)
	 competition.organization_id = org.id
	 competition.save!
	 @org_id = org.id
	 @comp_id = competition.id
	 session[:scorer_id] = @comp_id
  end
 
  test "should get index" do
    get :index
    assert_response :success
  end

end
