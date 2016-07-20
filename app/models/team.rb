class Team < ActiveRecord::Base
						
	has_many :alert_requests

	belongs_to :competition, foreign_key: "competition_id"
	belongs_to :manager, foreign_key: "competition_id"
	validates_presence_of :competition_id
	
	belongs_to :grouping, foreign_key: "grouping_id"
	validates_presence_of :grouping_id # ignore when creating root Grouping for a Competition
		
	has_many :contestants
	has_many :contests, through: :contestants
	
	has_many :alert_requests
	has_many :email_alerts
	has_many :sms_alerts
	
	validates_presence_of :name
	
	#self.table_name = "main.teams"
	
	# Since default_scope is private, we use this to allow access.
	def self.default_comp(comp_id)
		self.default_scope { (where(competition_id: comp_id) ) }
	end

	# Return an Array of all Contestants for which this is the Team.
	def as_contestants()
		Contestant.where(team: self)
	end

	# Return an Array of all Regularcontestants for which this is the Team.
	# This is useful for the Team's Standing within its Grouping.
	def as_regular_contestants()
	  Regularcontestant.where(team: self)
	end

	# Return an Array of all Contests for which this is one of the Teams.
	def contests()
		self.as_contestants.collect{|c| c.contest }
	end

	# Return count of all Regularcontestants for which this is the Team
	# and this score is more than the opponent's score.
	def wins()
		self.as_regular_contestants.select{|c| c.win()}.size()
	end

	# Return count of all Regularcontestants for which this is the Team
	# and this score is less than the opponent's score.
	def losses()
		self.as_regular_contestants.select{|c| c.loss()}.size()
	end

	# Return count of all Regularcontestants for which this is the Team
	# and this score is equal to the opponent's score.
	def draws()
		self.as_regular_contestants.select{|c| c.draw()}.size()
	end
	
	# Used for soccer results.
	def points()  
		(self.wins()*3+self.draws()) 
	end
	
	# Winning Percentage, expressed as a decimal.
	def pct()
	  (self.wins()==0) ? 0 : self.wins().to_f/(self.wins()+self.losses()) 
	end
	
	# Display version of Winning Percentage.
	def display_pct()
	  sprintf('%0.3f', self.pct())
	end
	
	# Used for Soccer Results.
	def goals_for()
	  self.as_regular_contestants.select{|c| c.score}.collect{|c| c.score}.inject{|gf, c| gf + c} || 0
	end
	
	# Used for Soccer Results.
	def goals_against()
	  self.as_regular_contestants.select{|c| c.opponent.score}.collect{|c| c.opponent.score}.inject{|gf, c| gf + c} || 0
	end
	
	# Goal Differential used in Soccer Results.
	def goal_diff()
	  self.goals_for() - self.goals_against()
	end
	
	# Varies by sport. (Deprecated?)
	def result_rowww(competition)
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
