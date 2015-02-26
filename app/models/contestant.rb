class Contestant < ActiveRecord::Base
	
  belongs_to :contest
  belongs_to :team
    
	
	 # Returns instance of a descendant of Contest class.
	 # This contestant is one of the two contestants for the contest.
	def contest
		Object.const_get(self.contest_type).find(self.contest_id)
	end
	
	
	def self.default_comp(comp_id)
		self.default_scope { (where(competition_id: comp_id) ) }
	end
	
	 # Returns instance of a descendant of Contestant class that is the
	 # other contestant in the Contest with this Contestant.
	def opponent
		homeaway=='H' ? self.contest.awaycontestant : self.contest.homecontestant
	end
	
	# A Win is a Win...
	def win()
		self.score() ? self.score() > self.opponent.score() : false
	end
	
	# But a Loss is a whole other thing...
	def loss()
		self.score() ? self.score() < self.opponent.score() : false
	end
	
	# Draws (when used) are when the scores are equal.
	def draw()
		self.score() ? self.score() == self.opponent.score() : false
	end
	
	
  
  def teamname
	  team_id ? Team.find(team_id).name : 'TBD'
  end
  
  def fullname
	  self.teamname()
  end
  
end
