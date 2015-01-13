class Venue < ActiveRecord::Base
	
	# Return true iff there are no Contests scheduled
	# nor any already completed at this location.
	def removeable?()
		Contest.where(venue: self).count==0
	end
	
end
