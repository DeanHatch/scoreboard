require 'test_helper'

class VenueTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  
   
	#
   test "venues fixtures are valid" do
	   [:maingym, :auxgym].each { |v| assert venues(v).valid? }
   end

end
