class Competition < ActiveRecord::Base
	
	enum sport: [ :basketball, :soccer ]
	enum variety: [ :tournament, :season, :league ]
	
	validates_presence_of :sport, :variety, :poolgroupseasonlabel, :playoffbracketlabel
	
	def Competition.poolgroupseasonlabels
		['Pool', 'Group', 'Season']
	end
        def Competition.playoffbracketlabels 
		['Playoff', 'Bracket']
	end
end
