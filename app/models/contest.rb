# This is the base class which contains the single table
# for all inherited Contest classes (Regularcontest, Bracketcontest, etc.)
# Because this has two associations of the type *has_one* to the same
# other class, we run into a problem when the Rails attribute workings
# attempts to maintain the integrity of the associations.  This is because
# two *has_one* associations is not the same as one *has_two*association.
class Contest < ActiveRecord::Base
	belongs_to :venue
	
	validates_associated :venue
	validates_presence_of :homecontestant
	validates_presence_of :awaycontestant
	
	has_one :homecontestant, -> { where homeaway: 'H' },
						class_name: "Contestant",
						foreign_key: "contest_id"
	has_one :awaycontestant, -> { where homeaway: 'A' },
						class_name: "Contestant",
						foreign_key: "contest_id"
	
	
	def self.default_comp(comp_id)
		self.default_scope { (where(competition_id: comp_id) ) }
	end
  
	
	# Create a collection of contest statuses.
	# This will be used to display selection choices and for validation.
	def Contest.statuses
		['SCHEDULED','POSTPONED','COMPLETED','FORFEIT','CANCELLED','FINAL']
	end
	
	
	# Create a collection of times throughout the day in five minute increments.
	# This will be used to display starting time choices for schedulers
	def Contest.times
		# Create a collection of times throughout the day in five minute increments
		# This will be used to display starting time choices for schedulers
		(1..287).to_a.collect {|i| [ (Time.new(0)+(i*5*60)).strftime('%I:%M %p').sub(/^0/, ""),
 					                     i.to_s ]}
	end


	# Attach the letters 'ant' to the end of the class name of this Contest
	# subclass object to determine the name of the Contestant subclass.
	# Return the Contestant subclass.
	def contestant_class()
		Object.const_get(self.class.name + 'ant')
	end
	
	# Each Contest (and all subclasses) must have two Contestants.
	# We initialize each Contest with two shell Contestants, one home Contestant
	# and one Away Contestant. The class of the Contestants is determined by
	# the subclass of this Contest class.
	# (Note: tried after_initialize but it did not work as I expected)
	def initialize(attributes = nil, options = {})
		super(attributes, options)
		self.awaycontestant = self.contestant_class.new(:contest_type => self.class.name,
                                                                   :forfeit => false,
								    homeaway: 'A',
								    contest_id: self.id)
		self.homecontestant = self.contestant_class.new(:contest_type => self.class.name,
                                                                  :forfeit => false,
								    homeaway: 'H',
								    contest_id: self.id)
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
		case self.time
			    # before 1AM
			when 1...11 then ("12:%02d AM" % ((self.time) * 5))
			    # from 1AM to just before Noon
			when 12...143 then ("%2d:%02d AM" % [(self.time / 12) , ((self.time % 12) * 5)])
			    # Noon
			when 144 then "Noon"
			    # after Noon
			when 145...287 then ("%2d:%02d PM" % [(self.time / 12) - 12 , ((self.time % 12) * 5)])
			else "TBD"
			end
	end
	
	# Team ID of Home Contestant, if any
	def home_team_id
		self.homecontestant ? self.homecontestant.team_id : nil
	end
	
	# Team ID of Away Contestant, if any
	def away_team_id
		self.awaycontestant ? self.awaycontestant.team_id : nil
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
		not (self.awaycontestant.score.nil? and (self.homecontestant.score.nil?))
	end
	
	# True if neither Team has a score.
	def needs_score?
		not self.has_score?
	end
	
	# Assign score to each Contestant and status to entire Contest.
	# Save all three records in a single transaction.
	def record_result(homescore, awayscore, status="COMPLETED")
		self.homecontestant.score = homescore
		self.awaycontestant.score = awayscore
		self.status = status
		logger.debug "connection: #{Contest.connection.inspect}"
		Contest.transaction do
			self.save!
			self.homecontestant.save!
			self.awaycontestant.save!
		end
	end
	
end
