require 'test_helper'

class RegularcontestTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  
	#
   test "regularcontests fixtures are valid" do
	   #[:rcone, :rctwo].each { |rc| assert regularcontests(rc).valid? }
	   [:gameone, :gametwo].each { |rc| assert regularcontests(rc).valid? }
	   #[:gameone].each { |rc| assert regularcontests(rc).valid? }
   end

end
