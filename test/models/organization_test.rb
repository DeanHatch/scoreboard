require 'test_helper'

class OrganizationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
   test "no blank organizations" do
     assert ! Organization.new.valid?
   end
  # 
   test "two test organizations" do
     assert Organization.all.size == 2
   end
  # 
   test "unique organization names" do
	   org2 = Organization.new
	   org2.name = organizations(:countyrec).name # same
	   assert ! org2.valid? , "Duplicate Name Should Not Have Been Allowed!"
   end
  # 
   test "unique organization names ok" do
	   org2 = Organization.new
	   org2.name = 'x'+organizations(:countyrec).name # distinct
	   assert org2.valid? , "Non-Duplicate Names Should Have Been Allowed!"
   end
  # 
end
