class Competition < ActiveRecord::Base
	
	belongs_to :customer
	
	enum sport: [ :basketball, :soccer ]
	enum variety: [ :tournament, :season, :league ]
	
	validates_presence_of :customer_id, :sport, :variety, :poolgroupseasonlabel, :playoffbracketlabel
	
	def Competition.poolgroupseasonlabels
		['Pool', 'Group', 'Season']
	end
        def Competition.playoffbracketlabels 
		['Playoff', 'Bracket']
	end
	
	# Note that since this is not a subclass of NestedModel, we must write our
	# own public method to access #default_scope.
	def Competition.default_cust(cust_id)
		self.default_scope { (where(customer_id: cust_id) ) }
	end
	
	# Display
	def result_headings()
		case self.sport
			when "basketball"
				["Wins", "Losses", "Pct"]
			when "soccer"
				["Wins", "Losses", "Draws", "Points", "GF", "GA", "GD"]
			else
				["Wins", "Losses"]
			end
		end
		
  

end
