require 'test_helper'

class ManagersControllerTest < ActionController::TestCase

  setup do
	   # Customer must exist for Competition foreign key.
	   # Manager inherits from Competition.
	   # Steps are:
	   #  1) Load Customer
	   #  2) Load Competition
	   #  3) Log Manager in to that Competition
	 cust = customers(:one)
	 cust.save!
	 competition = competitions(:soccer)
	 competition.customer_id = cust.id
	 competition.save!
  end
 
  test "should get choose_customer_manager" do
	get :choose_customer
  end

  test "should get choose_competition_manager" do
	get :choose_competition, customer_id: customers(:one).id
  end

  test "should get greet_manager" do
	get :greet, {} , {:manager_id => competitions(:soccer).id}
	assert_response :success
  end

  test "should redirect get greet_manager" do
	get :greet # session has no manager_id
	assert_redirected_to choose_customer_manager_path
  end

  test "should get passwords" do
	get :passwords, {} , {:manager_id => competitions(:soccer).id}
	assert_response :success
  end

  test "should patch change_password_manager" do
	patch :change_manager_password,
		{manager: { password: "yabba",
				password_confirmation: "yabba"} },
		{:manager_id => competitions(:soccer).id}
	assert_redirected_to greet_manager_path
  end

  test "should patch clear_manager_password_manager" do
	patch :clear_manager_password,
		{} , {:manager_id => competitions(:soccer).id}
	assert_redirected_to greet_manager_path
  end

  test "should patch change_scorer_password_manager" do
	patch :change_scorer_password,
		{manager: { password: "yabba",
				password_confirmation: "yabba"} },
		{:manager_id => competitions(:soccer).id}
	assert_redirected_to greet_manager_path
  end

  test "should patch clear_scorer_password_manager" do
	patch :clear_scorer_password,
		{} , {:manager_id => competitions(:soccer).id}
	assert_redirected_to greet_manager_path
  end

end
