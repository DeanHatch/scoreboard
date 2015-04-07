require 'test_helper'

class CustomerTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
   test "no blank customers" do
     assert ! Customer.new.valid?
   end
  # 
   test "two test customers" do
     assert Customer.all.size == 2
   end
  # 
   test "unique customer names" do
	   cust2 = Customer.new
	   cust2.userid = 'x'+customers(:alwaysright).userid # distinct
	   cust2.name = customers(:alwaysright).name # same
	   assert ! cust2.valid? , "Duplicate Name Should Not Have Been Allowed!"
   end
  # 
   test "unique customer userids" do
	   cust2 = Customer.new
	   cust2.userid = customers(:alwaysright).userid # same
	   cust2.name = 'x'+customers(:alwaysright).name # distinct
	   assert ! cust2.valid? , "Duplicate Userid Should Not Have Been Allowed!"
   end
end
