#  This class defines a Bracket for the purpose of collecting Bracketcontests.
#  A Bracket is a Grouping that has its bracket_grouping value set to true.
#  Each Bracket is the Grouping within which the Bracketcontests will be played.
class Bracket < Grouping
	
	has_many :bracketcontests
	
	def Bracket.all()
		super.where(bracket_grouping: true)
	end
	
	def all_participant_codes()
		apc = Hash.new
		Bracketcontest.where(bracket_id: self.id).
				each{|bc| apc[bc.name + ' Winner']="W#{bc.id}";
						apc[bc.name + ' Loser']="L#{bc.id}"}
		(self.all_subgroupings << self).select{|g|g.has_teams?}.
		     each{|g|(1..g.teams.count).
				each{|p| apc[p.ordinalize+' Place '+g.name]="G#{g.id}P#{p}"}}
		apc
	end
	
end
