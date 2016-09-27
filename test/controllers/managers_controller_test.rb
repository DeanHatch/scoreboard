require 'test_helper'

class ManagersControllerTest < ActionController::TestCase

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
	 @swizzle = competition
	 @org_id = org.id
	 @comp_id = competition.id
	 session[:manager_id] = @comp_id
  end
 
  test "should get greet_manager" do
	get :greet, {} , {:manager_id => @comp_id}
	assert_response :success
  end

  test "should redirect get greet_manager" do
	#session[:manager_id] = nil
	get :greet , {:manager_id => nil} ,
		{:manager_id => nil} # session has no manager (for this test only)
	assert_redirected_to oops_path
  end

  test "should get passwords" do
	get :passwords, {} , {:manager_id => @comp_id}
	assert_response :success
  end

  test "should patch change_password_manager" do
	patch :change_manager_password,
		{manager: { password: "yabba",
				password_confirmation: "yabba"} }
	assert_redirected_to greet_manager_path
  end

  test "should patch clear_manager_password" do
	patch :clear_manager_password,
		{} ,
		{:manager_id => @comp_id}
	assert_redirected_to greet_manager_path
  end

  test "should patch change_scorer_password" do
	patch :change_scorer_password,
		{manager: { password: "yabba",
				password_confirmation: "yabba"} },
		{:manager_id => @comp_id}
	assert_redirected_to greet_manager_path
  end

  test "should patch clear_scorer_password" do
    patch :clear_scorer_password,
		{} , 
		{}
    assert_redirected_to greet_manager_path
  end

end
