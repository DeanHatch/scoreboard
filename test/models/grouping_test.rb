require 'test_helper'

class GroupingTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
   test "no blank groupings" do
     assert ! Grouping.new.valid?
   end

	#
   test "groupings fixtures are valid" do
	   [:bballdiv1, :bballcon11, :bballdiv2, :bballcon22].each { |g| assert groupings(g).valid? }
   end

	#
   test "hierarchy works" do
	   assert_equal 3, groupings(:bballcon11).hierarchy.size
   end

	#
   test "subgroupings works" do
	   assert_equal 2, groupings(:bballdiv1).subgroupings.size
	   assert_equal 6, groupings(:bballroot).all_subgroupings.size
   end

	#
   test "teams works" do
	   assert groupings(:bballcon11).has_teams?
	   assert ! groupings(:bballroot).has_teams?
   end
   
end
