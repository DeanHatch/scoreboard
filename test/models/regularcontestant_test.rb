require 'test_helper'

class RegularcontestantTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
    
	#
   test "regularcontestants fixtures are valid" do
	   [:gameoneH, :gameoneA, :gametwoH, :gametwoA].each { |rc| assert regularcontestants(rc).valid? }
   end
    
	#
   test "regularcontestant opponents are working" do
	   assert_equal regularcontestants(:gameoneH).opponent , regularcontestants(:gameoneA)
	   assert_equal regularcontestants(:gametwoA).opponent , regularcontestants(:gametwoH)
	   assert_not_equal regularcontestants(:gameoneH).opponent , regularcontestants(:gametwoA)
   end

end
