require 'test_helper'

class ScorersControllerTest < ActionController::TestCase

  setup do
	   # Customer must exist for Competition foreign key.
	   # Manager inherits from Competition.
	   # Steps are:
	   #  1) Load Customer
	   #  2) Load Competition
	   #  3) Log Manager in to that Competition
	 #~ cust = customers(:alwaysright)
	 #~ cust.save!
	 #~ competition = competitions(:soccer)
	 #~ competition.customer_id = cust.id
	 #~ competition.save!
	 cust = customers(:squeakywheel)
	 cust.save!
	 competition = competitions(:bball)
	 competition.customer_id = cust.id
	 competition.save!
	 @cust_id = cust.id
	 @comp_id = competition.id
	 session[:scorer_id] = @comp_id
  end
 
  test "should get index" do
    get :index
    assert_response :success
  end

end
