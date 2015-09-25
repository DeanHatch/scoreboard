# This is the base class which contains the single table
# for all inherited Contest classes (Regularcontest, Bracketcontest, etc.)
# Because this has two associations of the type *has_one* to the same
# other class, we run into a problem when the Rails attribute workings
# attempts to maintain the integrity of the associations.  This is because
# two *has_one* associations is not the same as one *has_two*association.
class Contest < ActiveRecord::Base
	
	include Comparable
	
	belongs_to :competition
	belongs_to :manager
	belongs_to :venue
	
	validates_associated :venue
	validates_presence_of :homecontestant
	validates_presence_of :awaycontestant
	
	has_one :homecontestant, -> { where homeaway: 'H' },
						class_name: "Contestant",
						foreign_key: "contest_id", 
						dependent: :destroy  # destroys the associated homecontestant
	has_one :awaycontestant, -> { where homeaway: 'A' },
						class_name: "Contestant",
						foreign_key: "contest_id", 
						dependent: :destroy  # destroys the associated awaycontestant
	
	
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
	  super
	  self.awaycontestant = self.contestant_class.new(:contest_type => self.class.name,
                                                                   :forfeit => false,
								    homeaway: 'A',
								    competition: self.competition,
								    contest: self)
	  self.homecontestant = self.contestant_class.new(:contest_type => self.class.name,
                                                                  :forfeit => false,
								    homeaway: 'H',
								    competition: self.competition,
								    contest: self)
	end
	
	def save_all!()
	  Contest.transaction do
	    self.homecontestant.save!
	    logger.debug "homecontestant_id after save and before assignment: #{self.homecontestant_id.inspect}"
	    self.homecontestant_id = self.homecontestant.id # necessary? 
	    self.awaycontestant.save!
	    self.awaycontestant_id = self.awaycontestant.id
	    self.save!
	  end
	end
	
	def <=>(other_contest)
		(return other_contest.date.nil? ? 0 : -1) if self.date.nil?
		return 1 if other_contest.date.nil?
		return -1 if other_contest.date > self.date
		return 1 if other_contest.date < self.date
		   # Past here, both dates not nil and are equal
		(return other_contest.time.nil? ? 0 : -1) if self.time.nil?
		return 1 if other_contest.time.nil?
		return -1 if other_contest.time > self.time
		return 1 if other_contest.time < self.time
		0
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
	
	# True if either Team has a score.
	def has_score?
	  ['COMPLETED','FINAL'].include?(self.status)
	end
	
	# True if neither Team has a score.
	def needs_score?
	  ['SCHEDULED','POSTPONED'].include?(self.status)
	end
	
	# Assign score to each Contestant and status to entire Contest.
	# Save all three records in a single transaction.
	def record_result(homescore, awayscore, status="COMPLETED")
	  raise StandardError, ["Score was Incomplete (", 
					  self.awaycontestant.team.name(),
					  awayscore,
					  " at ",
	                                  self.homecontestant.team.name(),
					  homescore,
					  ")"].join(" ") if homescore.blank? or awayscore.blank?
	  self.homecontestant.score = homescore
	  self.awaycontestant.score = awayscore
	  self.status = status
	  #logger.debug "connection: #{Contest.connection.inspect}"
	  self.save_all!
	end
	
  def winning_team_and_score()
    self.homecontestant.win() ?
      self.home_team_and_score() :
      self.away_team_and_score()
  end
	
  def losing_team_and_score()
    self.homecontestant.win() ?
      self.away_team_and_score() :
      self.home_team_and_score()
  end
  
  def home_team_and_score()
    [self.homecontestant.team.name() , self.homecontestant.score().to_s()].join(" ")
  end
  
  def away_team_and_score()
    [self.awaycontestant.team.name() , self.awaycontestant.score().to_s()].join(" ")
  end
  
end
