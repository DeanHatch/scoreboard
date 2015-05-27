#! /usr/bin/env ruby


class Bracket < Object

  attr_accessor :numrounds, :pairings, :terminalpairing
  
    # Bracket(s) is(are) instantiated by controller via this class method
  def Bracket.all_for(bgrouping)
     bracketcontests = Bracketcontest.where(bracketgrouping: bgrouping)
     bracketcontestants = (bracketcontests.collect{|bc|bc.homecontestant})+
                            (bracketcontests.collect{|bc|bc.awaycontestant})
     priorcontests = bracketcontestants.select{|bc| bc.priorcontest()}.collect{|bc| bc.priorcontest()}
     terminalcontests = bracketcontests - priorcontests
     terminalcontests.collect {|tc| Bracket.new(tc) }
  end
  
  def initialize(bcontest)
    self.pairings = []
    self.numrounds = 1
    self.terminalpairing = Bracketpairing.new(self, 1, bcontest)
    nr = self.numrounds()
    self.pairings.each{|p| p.roundnum = nr+1-p.roundnum}
  end
  
  def numrounds()
    @numrounds = self.pairings.max_by{|p| p.roundnum}.roundnum
  end
  
  end
  
  
class Bracketnode < Object

  attr_accessor :roundnum, :homeside, :awayside
    
  end
  
  
class Bracketspacer < Bracketnode

  def initialize(rnum)
    self.roundnum = rnum
    self.homeside = nil
    self.awayside = nil
  end
  
  
  def upper_mid()
    "space "
  end

  def lower_mid()
    "space "
  end
  
  def inspect()
   "space "
  end

  end
  
  
class Bracketpairing < Bracketnode

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

  def top()
    [@bcontest.homecontestant.fullname(), @bcontest.homecontestant.score().inspect()].join(" ")
  end

  def upper_mid()
    [@bcontest.name(), @bcontest.display_date(), @bcontest.display_time].join(" ")
  end

  def lower_mid()
     @bcontest.venue_name()
  end

  def bottom()
    [@bcontest.awaycontestant.fullname(), @bcontest.awaycontestant.score().inspect()].join(" ")
  end
  
  def inspect()
    ["(", @bcontest.name(), self.awayside.inspect(), "at", self.homeside.inspect(),")"].join(" ")
  end
  
  end