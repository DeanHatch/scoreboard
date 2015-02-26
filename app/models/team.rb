class Team < ActiveRecord::Base
		
	belongs_to :grouping, foreign_key: "grouping_id"
	
	# Since default_scope is private, we use this to allow access.
	def self.default_comp(comp_id)
		self.default_scope { (where(competition_id: comp_id) ) }
	end

	# Return an Array of all Contestants for which this is the Team.
	def as_contestants()
		Contestant.where(team: self)
	end

	# Return count of all Contestants for which this is the Team
	# and this score is more than the opponent's score.
	def wins()
		self.as_contestants.select{|c| c.win()}.size()
	end

	# Return count of all Contestants for which this is the Team
	# and this score is less than the opponent's score.
	def losses()
		self.as_contestants.select{|c| c.loss()}.size()
	end

	# Return count of all Contestants for which this is the Team
	# and this score is equal to the opponent's score.
	def draws()
		self.as_contestants.select{|c| c.draw()}.size()
	end
	
	# Used for soccer results.
	def points()  
		(self.wins()*3+self.draws()) 
	end
	
	# 
	def pct()
		(self.wins()==0) ? 0 : self.wins().to_f/(self.wins()+self.losses()) 
	end
	
	# Varies by sport
	def result_row(competition)
		case competition.sport
			when "basketball"
				[self.wins(), self.losses(), sprintf('%0.3f', self.pct())]
			when "soccer"
				[self.wins(), self.losses(),  self.draws(), self.points(),
				 0, 0, 0]
			else
				[wins(), losses()]
			end
	end

end
