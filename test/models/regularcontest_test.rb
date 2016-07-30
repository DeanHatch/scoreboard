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
   test "saved regularcontest assigns all ids for #save_all!" do
	   rc = Regularcontest.new()
	   rc.competition = Competition.all.first
	   p 'Before Save: ' , rc.inspect(), rc.homecontestant.inspect(), rc.homecontestant.competition.inspect()
	   rc.save_all!
	   p 'After Save: ' , rc.inspect(), rc.homecontestant.inspect(), rc.homecontestant.competition.inspect()
	   assert rc.homecontestant.id
	   assert rc.homecontestant_id
	   assert rc.awaycontestant.id
	   assert rc.awaycontestant_id
	   assert rc.awaycontestant.contest.id
	   assert rc.awaycontestant.contest_id
   end
   test "saved regularcontest assigns all ids for #save" do
	   rc = Regularcontest.new()
	   rc.competition = Competition.all.first
	   p 'Before Save: ' , rc.inspect(), rc.homecontestant.inspect(), rc.homecontestant.competition.inspect()
	   rc.save
	   p 'After Save: ' , rc.inspect(), rc.homecontestant.inspect(), rc.homecontestant.competition.inspect()
	   assert rc.homecontestant.id
	   assert rc.homecontestant_id
	   assert rc.awaycontestant.id
	   assert rc.awaycontestant_id
	   assert rc.awaycontestant.contest.id
	   assert rc.awaycontestant.contest_id
   end


end
