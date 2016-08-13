# Bracketcontest adds functionality related to the contestants.
# Contestants may be winners/losers of prior Bracketcontests,
# for example.
class Bracketcontest < Contest
	
	belongs_to :bracketgrouping, foreign_key: "bracketgrouping_id"
	
	has_many :bcadvancements, foreign_key: "from_contest_id"
	
	validates :competition_id,
		     :bracketgrouping_id,
		     :homecontestant,
		     :awaycontestant,
		     presence: true
	

  
	# Assign score to each Bracketcontestant and status to entire Bracketcontest.
	# Save all three records in a single transaction. This overrides (adds to)
	# inherited method by automatically advancing teams if this
	# Bracketcontest is referred to by the contestants of a
	# subsequent Bracketcontest.
  def record_result(homescore, awayscore, status="COMPLETED")
    super(homescore, awayscore, status)
    self.advance_contestants()
  end
  
    # 
  def bracketdepth()
    self.has_prior? ?
      [self.homecontestant.bracketdepth(), self.awaycontestant.bracketdepth()].max + 1 :
      1
  end
  
    #
  def has_prior?()
    ! (self.homecontestant.priorcontest.nil? and self.awaycontestant.priorcontest.nil?)
  end
  
    # return the contestantcode for the Winner of this Bracketcontest
  def winner_code()
    "W"+self.id.to_s
  end
  
    # return the contestantcode for the Loser of this Bracketcontest
  def loser_code()
    "L"+self.id.to_s
  end
  
    # Returns Array of Bracketcontestants which refer to this Bracketcontest.
  def all_priors()
    #self.bracketgrouping.bracketcontests.bracketcontestants
    #Bracketcontestant.where(bracketgrouping: self.bracketgrouping).select{|bc|bc.priorcontest().id()==self.id()}.collect{|bc|bc.priorcontest()}
    self.bcadvancements.collect {|bcadv| bcadv.bracketcontestant}
  end
	
	# Advance teams if this Bracketcontest is referred to by the contestants of a
	# subsequent Bracketcontest.
  def advance_contestants()
    #logger.debug "Prior(s): #{all_priors.collect{|bc| bc.contestantcode}.inspect()}"
    winning_team = self.homecontestant.win ? self.homecontestant.team : self.awaycontestant.team
    losing_team = self.homecontestant.loss ? self.homecontestant.team : self.awaycontestant.team
    self.all_priors().each{|bc| bc.team = bc.contestanttype=="W" ? winning_team : losing_team; bc.save! }
  end
	
end
