class Contest < ActiveRecord::Base
	belongs_to :venue
	
	validates_associated :venue
	
	has_one :homecontestant, -> { where homeaway: 'H' },
						class_name: "Contestant",
						foreign_key: "contest_id"
	has_one :awaycontestant, -> { where homeaway: 'A' },
						class_name: "Contestant",
						foreign_key: "contest_id"
	
	
	# Create a collection of contest statuses.
	# This will be used to display selection choices and for validation.
	def Contest.statuses
		['SCHED','PPD','COMP','FORFEIT','CANCELLED','FINAL']
	end
	
	
	# Create a collection of times throughout the day in five minute increments.
	# This will be used to display starting time choices for schedulers
	def Contest.times
		# Create a collection of times throughout the day in five minute increments
		# This will be used to display starting time choices for schedulers
		5.step((24*60-5), 5).to_a.
					collect {|m| [ (Time.new(0)+(m*60)).strftime('%I:%M %p').sub(/^0/, ""),
 					                     (Time.new(0)+(m*60)).strftime('%I:%M %p').sub(/^0/, "") ]}
	end
	
	
	# Convenience method. Display "TBD" for nil.
	def venue_name
		self.venue_id ? Venue.find(venue_id).name : 'TBD'
	end
	
	# Convenience method. Display "TBD" for nil.
	def display_date
		self.date ? self.date.strftime('%m/%d/%Y').sub(/^0/, "") : 'TBD'
	end
	
	# Convenience method. Display "TBD" for nil.
	def display_time
		self.time ? self.time.strftime('%I:%M %p').sub(/^0/, "") : 'TBD'
	end
	
	# Full name can be customized for different contestant types.
	def homecontestant_fullname
		self.homecontestant.fullname
	end
	
	# Full name can be customized for different contestant types.
	def awaycontestant_fullname
		self.awaycontestant.fullname
	end
	
	# True if either Team has a score.
	def has_score?
		not self.awaycontestant.score.nil? and (self.homecontestant.score.nil?)
	end
	
	# True if neither Team has a score.
	def needs_score?
		not self.has_score?
	end
	
end
