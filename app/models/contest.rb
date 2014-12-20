class Contest < ActiveRecord::Base
	belongs_to :venue
	
	validates_associated :venue
	#validates_presence_of :venue_id
	
	def Contest.statuses
		['SCHED','PPD','COMP','FORFEIT','CAN','FINAL']
	end
	
	def venue_name
		self.venue_id ? Venue.find(venue_id).name : 'TBD'
	end
	
end
