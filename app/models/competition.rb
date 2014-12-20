class Competition < ActiveRecord::Base
	has_one :grouping 
	
	enum sport: [ :basketball, :soccer ]
	enum variety: [ :tournament, :season, :league ]
	def Competition.poolgroupseasonlabels
		['Pool', 'Group', 'Season']
	end
        def Competition.playoffbracketlabels 
		['Playoff', 'Bracket']
	end
end
