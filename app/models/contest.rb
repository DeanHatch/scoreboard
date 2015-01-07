class Contest < ActiveRecord::Base
	belongs_to :venue
	
	validates_associated :venue
	#validates_presence_of :venue_id
	
	def Contest.statuses
		['SCHED','PPD','COMP','FORFEIT','CAN','FINAL']
	end
	
	def Contest.times
		# Create a collection of times throughout the day in five minute increments
		# This will be used to display starting time choices for schedulers
		5.step((24*60-5), 5).to_a.
					collect {|m| [ (Time.new(0)+(m*60)).strftime('%I:%M %p').sub(/^0/, ""),
 					                     (Time.new(0)+(m*60)).strftime('%I:%M %p').sub(/^0/, "") ]}
	end
	
	
	def venue_name
		self.venue_id ? Venue.find(venue_id).name : 'TBD'
	end
	
	def display_date
		self.date ? self.date.strftime('%m/%d/%Y').sub(/^0/, "") : 'TBD'
	end
	
	def display_time
		self.time ? self.time.strftime('%I:%M %p').sub(/^0/, "") : 'TBD'
	end
	
end
