class Bracketcontestant < Contestant
  belongs_to :bracketcontest
  belongs_to :team
  
  def teamname
	  team_id ? Team.find(team_id).name : 'TBD'
  end
  
  def fullname
	  self.teamname()
  end
  
end
