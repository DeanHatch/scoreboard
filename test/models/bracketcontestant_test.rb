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
  test "bcadvancement bcspecs are correct" do
    # bcadvancements(:bcgameonewinner)
    assert ! bcadvancements(:bcgameonewinner).from_contest.name().nil?
    [:thunder].each { |t| assert_equal 1, teams(t).wins }
  end
  
  #
  test "bcadvancement bcspec creates correctly" do
    ship = contests(:bcgamethree)
    consolationgame = Bracketcontest.new(competition: competitions(:bball),
                                                               bracketgrouping: Bracketgrouping.find(groupings(:bballdiv1).id))
    consolationgame.name = 'Consolation Game'
    consolationgame.date = ship.date
    consolationgame.save() # must be saved before bcspec instantiated
    assert ! consolationgame.homecontestant.nil?
    (consolationgame.homecontestant.bcspec = Bcadvancement.new(from_contest: contests(:bcgameone),
													wl: 'L')).save()
    (consolationgame.awaycontestant.bcspec = Bcadvancement.new(from_contest: contests(:bcgametwo),
													wl: 'L')).save()
    assert ! bcadvancements(:bcgameonewinner).from_contest.name().nil?
    Bcadvancement.all.each{|pbc| puts pbc.inspect()}
  end
    
end
