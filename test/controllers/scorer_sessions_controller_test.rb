require 'test_helper'

class ScorerSessionsControllerTest < ActionController::TestCase

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
  end

  test "should get new" do
	  scorer = Scorer.find_by_name(competitions(:bball).name)
	  get :new, { scorer_id: scorer.id }
    assert_redirected_to :scorer_index
  end

  test "should get create" do
    scorer = competitions(:bball)
    post :create, scorer_session: { password: 'secretpw', scorer_id: scorer.id }
    assert_redirected_to :scorer_index
  end

  test "should get logout" do
    get :logout
    assert_redirected_to :root
  end

end
