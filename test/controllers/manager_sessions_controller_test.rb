require 'test_helper'

class ManagerSessionsControllerTest < ActionController::TestCase

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

  test "should get new" do
	  manager = Manager.find_by_name(competitions(:soccer).name)
	  get :new, { manager_id: manager.id }
    assert_redirected_to greet_manager_path
  end

  test "should post create" do
    manager = competitions(:soccer)
    post :create, manager_session: { password: 'secretpw', manager_id: manager.id }
    assert_redirected_to greet_manager_path
  end

end
