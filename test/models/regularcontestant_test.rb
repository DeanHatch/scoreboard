require 'test_helper'

class RegularcontestantTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
    
	#
   test "regularcontestants fixtures are valid" do
	   [:rcgameoneH, :rcgameoneA, :rcgametwoH, :rcgametwoA].each { |rc| assert contestants(rc).valid? }
   end
    
	#
   test "regularcontestant opponents are working" do
	   assert_equal contestants(:rcgameoneH).opponent , contestants(:rcgameoneA)
	   assert_equal contestants(:rcgametwoA).opponent , contestants(:rcgametwoH)
	   assert_not_equal contestants(:rcgameoneH).opponent , contestants(:rcgametwoA)
   end

end
