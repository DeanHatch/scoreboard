require 'test_helper'

class BracketcontestantTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  
  #
  test "create grouping/place bcspec" do
    assert true
  end
  
  #
  test "priorbracketcontest bcspecs are correct" do
    # priorbracketcontests(:bcgameonewinner)
    assert ! priorbracketcontests(:bcgameonewinner).bracketcontest.name().nil?
    [:thunder].each { |t| assert_equal 1, teams(t).wins }
  end
  
  #
  test "priorbracketcontest bcspec creates correctly" do
    ship = contests(:bcgamethree)
    consolationgame = Bracketcontest.new(competition: competitions(:bball),
                                                               bracketgrouping: Bracketgrouping.find(groupings(:bballdiv1)))
    consolationgame.name = 'Consolation Game'
    consolationgame.date = ship.date
    consolationgame.save() # must be saved before bcspec instantiated
    assert ! consolationgame.homecontestant.nil?
    (consolationgame.homecontestant.bcspec = Priorbracketcontest.new(bracketcontest: contests(:bcgameone),
													wl: 'L')).save()
    (consolationgame.awaycontestant.bcspec = Priorbracketcontest.new(bracketcontest: contests(:bcgametwo),
													wl: 'L')).save()
    assert ! priorbracketcontests(:bcgameonewinner).bracketcontest.name().nil?
    Priorbracketcontest.all.each{|pbc| puts pbc.inspect()}
  end
    
end
