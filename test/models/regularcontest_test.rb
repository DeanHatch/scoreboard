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

	#
   test "regularcontests creates both contestants" do
	   assert Regularcontest.new().homecontestant
	   assert Regularcontest.new().awaycontestant
   end

	#
   test "saved regularcontest assigns all ids for #save!" do
	   rc = Regularcontest.new()
	   rc.competition = Competition.all.first
	   rc.save!
	   assert rc.homecontestant.id, "homecontestant.id nil"
	   assert rc.homecontestant_id, "homecontestant_id nil"
	   assert rc.awaycontestant.id, "homecontestant.id nil"
	   assert rc.awaycontestant_id, "awaycontestant_id nil"
	   assert rc.awaycontestant.contest, "awaycontestant's contest nil"
	   assert rc.awaycontestant.contest.id, "awaycontestant's contest's id nil"
	   assert rc.awaycontestant.contest_id, "awaycontestant's contest_id nil"
   end
   
   test "saved regularcontest assigns all ids for #save" do
	   rc = Regularcontest.new()
	   rc.competition = Competition.all.first
	   rc.save
	   assert rc.homecontestant.id, "homecontestant.id nil"
	   assert rc.homecontestant_id, "homecontestant_id nil"
	   assert rc.awaycontestant.id, "homecontestant.id nil"
	   assert rc.awaycontestant_id, "awaycontestant_id nil"
	   assert rc.awaycontestant.contest, "awaycontestant's contest nil"
	   assert rc.awaycontestant.contest.id, "awaycontestant's contest's id nil"
	   assert rc.awaycontestant.contest_id, "awaycontestant's contest_id nil"
   end

end
