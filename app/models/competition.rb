# This class contains the essentials for a Competition.  All other non-Customer
# resources are nested within this resource.
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
	
	# Display table headings for Standings for a Grouping or
	# for a Team's record.
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
		
	# Name, Sport, and Variety of Competition, suitable for a title or heading.
	def fullname()
		[self.name(), self.sport().titleize, self.variety().titleize].join(" ")
	end

end
