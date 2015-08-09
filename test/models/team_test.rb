require 'test_helper'

class TeamTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  
	#
   test "teams fixtures are valid" do
	   [:heat, :thunder, :lightning, :blizzard].each { |t| assert teams(t).valid? }
	   newteam = Team.new() # no Competition or Grouping or Name
	   assert ! newteam.valid?
	   newteam.name = "Dynomite" # no Grouping or Competition
	   assert ! newteam.valid?
	   newteam.competition = competitions(:bball) # still no Grouping
	   assert ! newteam.valid?
	   newteam.grouping = groupings(:bballcon22) # should now be valid
	   assert  newteam.valid?
	   newteam.competition = nil # now no Competition
	   assert ! newteam.valid?
   end

	#
   test "teams wins/losses are correct (only counts Regular)" do
	   [:thunder].each { |t| assert_equal 1, teams(t).wins }
	   [:thunder].each { |t| assert_equal 0, teams(t).losses }
	   [:heat].each { |t| assert_equal 1, teams(t).losses }
	   [:lightning].each { |t| assert_equal 1, teams(t).wins }
	   [:hailstones].each { |t| assert_equal 1, teams(t).losses }
   end

end
