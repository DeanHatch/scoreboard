require 'test_helper'

class CustomersControllerTest < ActionController::TestCase

  setup do
	   # Customer must exist for Organization foreign key.
	   # Steps are:
	   #  1) Load Customer
	   #  2) Load Organization
	 #~ cust = customers(:alwaysright)
	 #~ cust.save!
	 #~ organization = organizations(:soccer)
	 #~ organization.customer_id = cust.id
	 #~ organization.save!
	 cust = customers(:squeakywheel)
	 cust.save!
	 session[:customer_id] = cust.id
	 org = organizations(:countyrec)
	 puts org.methods.select{|m| m.to_s()[0]=='c'}.sort.join(' ')
	 puts "****"
	 puts org.inspect()
	 #org.customer= cust
	 org.save!
  end
 
  #~ test "should get show" do
    #~ get :show
    #~ assert_response :success
  #~ end

end
