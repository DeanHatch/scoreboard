require 'test_helper'

class ManagerSessionsControllerTest < ActionController::TestCase

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
  end

  test "should get new" do
	  manager = Manager.find_by_name(competitions(:bball).name)
	  get :new, { manager_id: manager.id }
    assert_redirected_to greet_manager_path
  end

  test "should post create" do
    manager = competitions(:bball)
    post :create, manager_session: { password: 'secretpw', manager_id: manager.id }
    assert_redirected_to greet_manager_path
  end

end
