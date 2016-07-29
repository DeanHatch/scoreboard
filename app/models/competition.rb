require 'digest/sha1'

# This class contains the essentials for a Competition
class Competition < ActiveRecord::Base
	
	belongs_to :customer
	
	enum sport: [ :basketball, :soccer, :quidditch ]
	enum variety: [ :tournament, :season, :league ]
	
	validates_presence_of :customer_id, :sport, :variety,
				:poolgroupseasonlabel, :playoffbracketlabel
	
	attr_accessor :manager_password_confirmation
	validates_confirmation_of :manager_password
	
	attr_accessor :scorer_password_confirmation
	validates_confirmation_of :scorer_password
	
	has_many :venues
	has_many :validdates
	has_many :valid_times
	has_many :groupings
	has_many :bracketgroupings, -> { where(bracket_grouping: true) }
	has_many :teams, through: :groupings
	has_many :contests
	has_many :regularcontests
	has_many :contestants, through: :contests
	
	
	
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

	
	# Varies by sport
	def result_row()
		case self.sport
			when "basketball"
				[:wins, :losses, :display_pct]
			when "soccer"
				[:wins, :losses,  :draws, :points,
				 :goals_for, :goals_against, :goal_diff]
			else
				[:wins, :losses]
			end
	end

	
	# Varies by sport
	def compare_teams(a, b)
		case self.sport
			when "basketball"
			  b.send(:pct) == a.send(:pct) ? 
			  b.send(:wins) <=> a.send(:wins) :
			    b.send(:pct) <=> a.send(:pct)
			when "soccer"
			  b.send(:points) == a.send(:points) ? 
			    b.send(:goal_diff) <=> a.send(:goal_diff) :
			    b.send(:points) <=> a.send(:points)
			else
			  b.send(:pct) <=> a.send(:pct)
			end
	end
		
	# Name, Sport, and Variety of Competition, suitable for a title or heading.
	def fullname()
		[self.name(), self.sport().titleize, self.variety().titleize].join(" ")
	end

      

		
	def self.authenticate_manager(compid, mgrpw)
		logger.info("finding Compd ID: #{compid}")
		logger.info("mgrpw: #{mgrpw.inspect()}")
		comp = self.find(compid)
		logger.info("Compd ID after find: #{comp.id}")
		  # Skip password check if there is no password!
		return comp if comp and comp.hashed_manager_password.nil?
		logger.info("hashed manager pw: #{comp.hashed_manager_password.inspect()}")
		if comp 
			expected_password = encrypted_password(mgrpw, comp.salt)
			if comp.hashed_manager_password != expected_password
				comp = nil
			end
		end
		comp
	end
	
	
    # Make sure our list makes sense to users.
  def valid_times_sorted()
    self.valid_times.sort{|a,b|a.from_time <=> b.from_time}
  end

    # If this Competition does not have its own list of
    # Valid Time Ranges, then use the default.
  def valid_times_as_select_options()
    self.valid_times.size()==0 ? 
      ValidTime.default.select_options() :
      self.valid_times_sorted.inject([]){|opt,vt| opt + vt.select_options()}
  end
	
	
	# manager_password is included on the HTML form and is sent with
	# the HTTP request but hashed_manager_password is what
	# is stored in the database after passing manager_password
	# through a SHA1 digest.
	def manager_password
		@manager_password
	end
	
	def manager_password=(pwd)
		@manager_password = pwd
		return if pwd.blank?
		create_new_salt
		self.hashed_manager_password = Competition.encrypted_password(self.manager_password, self.salt)
	end
	
	def clear_manager_password()
		@manager_password = nil
		self.hashed_manager_password = nil
	end
	
	  # Override by adding creation of a root Grouping if this save
	  # is a creation save ass opposed to an update save.
	def save
		news_to_me = self.new_record?
		super()
		create_root_grouping() if news_to_me
	end
	
	  # Used when creating a new Competition.
	def create_root_grouping()
		name = self.name + ' ' + self.variety.humanize
		Grouping.new(competition_id: self.id, name: name).save(validate: false)
	end
	
	
	# This Competition's Grouping which has no parent.
	def top_grouping()
		self.groupings.where(parent_id: nil).first
	end
	
	
	# scorer_password is included on the HTML form and is sent with
	# the HTTP request but hashed_scorer_password is what
	# is stored in the database after passing scorer_password
	# through a SHA1 digest.
	def scorer_password
		@scorer_password
	end
	
	def scorer_password=(pwd)
		@scorer_password = pwd
		return if pwd.blank?
		create_new_salt
		self.hashed_scorer_password = Competition.encrypted_password(self.scorer_password, self.salt)
	end
	
	def clear_scorer_password()
		@scorer_password = nil
		self.hashed_scorer_password = nil
	end
	
protected

	# Both passwords (manager and scorer) share the same salt.
	# It is only assigned if  it is requested and is nil.
	def create_new_salt
		(self.salt = self.object_id.to_s + rand.to_s) if self.salt.nil?
	end
	
	
	def self.encrypted_password(password, salt)
		return nil if password.nil?
		string_to_hash = password + "dingus" + salt
		Digest::SHA1.hexdigest(string_to_hash)
	end
	
private
	

end
