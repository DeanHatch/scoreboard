#! /usr/bin/env ruby

# This class facilitates the display of Bracket contests, visually linking them together
# so that the advancement of winners is clearly obvious. In order to
# achieve this result, this class acts as
# a container for a number of Bracketpairing objects. This container
# organizes the pairs and provides access to the "root" pairing, which is the
# terminal pairing (i.e. "championship" or last round or whatever pairing from
# which neither Team advances) and also provides the number of rounds of
# pairings. The number of rounds is the maximum depth of the binary tree.
# 
# Note that there might be more than one Bracket for a Bracketgrouping.
#
# Attributes are:
# [pairings] Array of all Bracketpairing objects in this Bracket
# [terminalpairing] "root" of the "tree"
# 
class Bracket < Object

  attr_accessor :pairings, :terminalpairing
  
    # Each Bracket is instantiated by a controller via this class method. This method
    # first finds all terminal pairings for the the given Bracketgrouping, and then
    # creates a Bracket for each one.
  def Bracket.all_for(bgrouping)
     bracketcontests = Bracketcontest.where(bracketgrouping: bgrouping)
     bracketcontestants = (bracketcontests.collect{|bc|bc.homecontestant})+
                            (bracketcontests.collect{|bc|bc.awaycontestant})
     priorcontests = bracketcontestants.select{|bc| bc.priorcontest()}.collect{|bc| bc.priorcontest()}
     terminalcontests = bracketcontests - priorcontests
     terminalcontests.collect {|tc| Bracket.new(tc) }
  end
  
    # The instantiation of a Bracket begins with the terminal ("root") pairing
    # and grabs each prior Bracketcontest within the Bracketgrouping, where
    # a prior Bracketcontest is defined as one whose winner moves on to this
    # the currently considered pairing.
  def initialize(bcontest)
    self.pairings = []
    #self.numrounds = 1
    self.terminalpairing = Bracketpairing.new(self, 1, bcontest)
    nr = self.numrounds()
    self.pairings.each{|p| p.roundnum = nr+1-p.roundnum}
  end
  
    # During construction of the collection of pairings, the round numbers start with
    # the "root", or terminalpairing, at 1. After construction, the round numbers are
    # all adjusted so that the most extreme leaf is at 1 and the terminal pairing is at
    # the depth of the tree. This method returns the maximum round number found, 
    # so it works both before adjustment and after adjustment.
  def numrounds()
    @numrounds = self.pairings.max_by{|p| p.roundnum}.roundnum
  end
  
  end
  
  
  
# Objects of this class give details of the display of a Bracketcontest and also
# link to the Bracketcontests in the immediately prior round which lead into this
# Bracketcontest.
#
# Note that there might be more than one Bracket for a Bracketgrouping.
#
# Attributes are:
# [roundnum] total depth of the tree minus the depth of this node
# [homeside] Link to Bracketpairing, the winner of which is the Home Team for this pairing
# [awayside] Link to a Bracketpairing, the winner of which is the Away Team for this pairing
# 
class Bracketpairing < Object

  attr_accessor :roundnum, :homeside, :awayside

    # The containing Bracket object passes itself as a parameter so that this object can add itself to
    # its parent's collection.
  def initialize(bracket, rnum, bcontest)
    self.roundnum = rnum
    @bcontest = bcontest
    bracket.pairings << self
    self.homeside = (bcontest.homecontestant.contestanttype() == "W" ?
				Bracketpairing.new(bracket, rnum+1, bcontest.homecontestant.priorcontest()) :
				nil)
    self.awayside = (bcontest.awaycontestant.contestanttype() == "W" ?
				Bracketpairing.new(bracket, rnum+1, bcontest.awaycontestant.priorcontest()) :
				nil)
  end

    # Text of the top portion of the Bracketpairing, that is, the Home Team.
  def top()
    [@bcontest.homecontestant.briefname(), @bcontest.homecontestant.score().to_s()].join(" ")
  end

    # Text of the middle is two parts. This is the first of the two.
  def upper_mid()
    [@bcontest.name(), @bcontest.display_date(), @bcontest.display_time].join(" ")
  end

    # Text in the middle of the pairing is two parts. This is the second of the two.
  def lower_mid()
     @bcontest.venue_name()
  end

    # Text of the bottom portion of the Bracketpairing, that is, the Away Team.
  def bottom()
    [@bcontest.awaycontestant.briefname(), @bcontest.awaycontestant.score().to_s()].join(" ")
  end
  
  def inspect()
    ["(", @bcontest.name(), self.awayside.inspect(), "at", self.homeside.inspect(),")"].join(" ")
  end
  
  end