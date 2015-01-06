class Venue < ActiveRecord::Base
	
	def removeable()
		Contest.where(venue: self).count==0
	end
	
end
