# Bracketcontest adds functionality related to the contestants.
# Contestants may be winners/losers of prior Bracketcontests,
# for example.
class Bracketcontest < Contest
	
	belongs_to :bracketgrouping, foreign_key: "bracketgrouping_id"
	
	validates :competition_id,
		     :bracketgrouping_id,
		     :homecontestant,
		     :awaycontestant,
		     presence: true
	
	# Provide controlled public access to private class method.
  def self.default_bracketgrouping(bracketgrouping_id)
	  self.default_scope { (where(bracketgrouping_id: bracketgrouping_id) ) }
  end
  
  
	# Assign score to each Bracketcontestant and status to entire Bracketcontest.
	# Save all three records in a single transaction. This overrides (adds to)
	# inherited method by automatically advancing teams if this
	# Bracketcontest is referred to by the contestants of a
	# subsequent Bracketcontest.
  def record_result(homescore, awayscore, status="COMPLETED")
    super(homescore, awayscore, status)
    self.advance_contestants()
  end
  
  
    # return the contestantcode for the Winner of this Bracketcontest
  def winner_code()
    "W"+self.id.to_s
  end
  
    # return the contestantcode for the Loser of this Bracketcontest
  def loser_code()
    "L"+self.id.to_s
  end
  
	
	# Advance teams if this Bracketcontest is referred to by the contestants of a
	# subsequent Bracketcontest.
  def advance_contestants()
    all_priors = Bracketcontestant.all.select{|bc|bc.priorcontest==self}
    #logger.debug "Prior(s): #{all_priors.collect{|bc| bc.contestantcode}.inspect()}"
    winning_team = self.homecontestant.win ? self.homecontestant.team : self.awaycontestant.team
    losing_team = self.homecontestant.loss ? self.homecontestant.team : self.awaycontestant.team
    all_priors.each{|bc| bc.contestanttype=="W" ? bc.team = winning_team : losing_team; bc.save! }
  end
	
end
