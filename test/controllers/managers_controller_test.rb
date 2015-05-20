require 'test_helper'

class ManagersControllerTest < ActionController::TestCase

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
	 session[:manager_id] = @comp_id
  end
 
  test "should get choose_customer_manager" do
	get :choose_customer
  end

  test "should get choose_competition_manager" do
	 session[:manager_id] = nil # not yet selected
	get :choose_competition, customer_id: @cust_id
  end

  test "should get greet_manager" do
	get :greet, {} , {:manager_id => @comp_id}
	assert_response :success
  end

  test "should redirect get greet_manager" do
	session[:manager_id] = nil
	get :greet # session has no manager_id
	assert_redirected_to choose_customer_manager_path
  end

  test "should get passwords" do
	get :passwords, {} , {:manager_id => @comp_id}
	assert_response :success
  end

  test "should patch change_password_manager" do
	patch :change_manager_password,
		{competition: { password: "yabba",
				password_confirmation: "yabba"} },
		{:manager_id => @comp_id}
	assert_redirected_to greet_manager_path
  end

  test "should patch clear_manager_password" do
	patch :clear_manager_password,
		{} , {:manager_id => @comp_id}
	assert_redirected_to greet_manager_path
  end

  test "should patch change_scorer_password" do
	patch :change_scorer_password,
		{competition: { password: "yabba",
				password_confirmation: "yabba"} },
		{:manager_id => @comp_id}
	assert_redirected_to greet_manager_path
  end

  test "should patch clear_scorer_password" do
	patch :clear_scorer_password,
		{manager: {}} , {:manager_id => @comp_id}
	assert_redirected_to greet_manager_path
  end

end
