class Contestant < ActiveRecord::Base
	
	 # Returns instance of a descendant of Contest class.
	 # This contestant is one of the two contestants for the contest.
	def contest
		Object.const_get(self.contest_type).find(self.contest_id)
	end
	
	
	 # Returns instance of a descendant of Contestant class that is the
	 # other contestant in the Contest with this Contestant.
	def opponent
		homeaway=='H' ? self.contest.awaycontestant : self.contest.homecontestant
	end
	
  
  def teamname
	  team_id ? Team.find(team_id).name : 'TBD'
  end
  
  def fullname
	  self.teamname()
  end
  
end
