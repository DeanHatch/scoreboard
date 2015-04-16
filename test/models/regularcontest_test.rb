require 'test_helper'

class RegularcontestTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
    
  test "sortable" do
	  #p Contest.all.collect{|c| [c.display_date, c.display_time, c.type, c.class.name].join(" ")}.join(" -- ")
	  assert_equal contests(:rcgameone) , contests(:rcgametwo) # "equal" means "same day/time"
  end
 
	#
   test "regularcontests fixtures are valid" do
	   #[:rcone, :rctwo].each { |rc| assert regularcontests(rc).valid? }
	   [:rcgameone, :rcgametwo].each { |rc| assert contests(rc).valid? }
	   #[:gameone].each { |rc| assert regularcontests(rc).valid? }
   end

end
