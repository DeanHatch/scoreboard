# Bracketcontest adds functionality related to the contestants.
# Contestants may be winners/losers of prior Bracketcontests,
# for example.
class Bracketcontest < Contest
		
	belongs_to :bracket, foreign_key: "bracket_id"
		
	has_one :homecontestant, -> { where homeaway: 'H' },
						class_name: "Bracketcontestant",
						foreign_key: "contest_id"
	has_one :awaycontestant, -> { where homeaway: 'A' },
						class_name: "Bracketcontestant",
						foreign_key: "contest_id"
	
	validates :competition_id,
		     :bracket_id,
		     :homecontestant,
		     :awaycontestant,
		     presence: true
	
	# Provide controlled public access to private class method.
  def self.default_bracket(bracket_id)
   self.default_scope { (where(bracket_id: bracket_id) ) }
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
