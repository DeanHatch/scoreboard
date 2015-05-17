require 'test_helper'

class BracketTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
    
    # These three edge cases should be sufficient
  test "se_matchups" do
	assert  brackets(:bballdiv1).se_matchups(7) == [[[1, nil], [4, 5]], [[2, 7], [3, 6]]]
	assert  brackets(:bballdiv1).se_matchups(8) == [[[1, 8], [4, 5]], [[2, 7], [3, 6]]]
	assert  brackets(:bballdiv1).se_matchups(9) == [[[[1, nil], [8, 9]], [[4, nil], [5, nil]]], [[[2, nil], [7, nil]], [[3, nil], [6, nil]]]]
  end
     
  test "for_pair" do
	#p Bracketcontest.for_pair()
	#p Bracketcontest.all.collect{|c| c.display_date + " " + c.display_time}.join(" ")
  end
    
    # Seven Teams should result in the creation of Six Bracketcontests
  test "for_pair_champs" do
    assert_difference('Bracketcontest.count', 6) do
      matchups =  brackets(:bballdiv1).for_pair(brackets(:bballdiv1).se_matchups(7))
    end
  end
  
end
