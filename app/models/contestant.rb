class Contestant < ActiveRecord::Base
  belongs_to :contest, polymorphic: true
  belongs_to :team
  #belongs_to :bracketcontest
  belongs_to :grouping
  
  def teamname
	  team_id ? Team.find(team_id).name : 'TBD'
  end
  
  def fullname
	  self.teamname()
  end
  
end
