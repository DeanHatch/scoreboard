require 'digest/sha1'

# This class contains the essentials for a Competition.  All other non-Customer
# resources are nested within this resource.
class Competition < ActiveRecord::Base
	
	belongs_to :customer
	
	enum sport: [ :basketball, :soccer ]
	enum variety: [ :tournament, :season, :league ]
	
	validates_presence_of :customer_id, :sport, :variety,
				:poolgroupseasonlabel, :playoffbracketlabel
	
	attr_accessor :manager_password_confirmation
	validates_confirmation_of :manager_password
	
	attr_accessor :scorer_password_confirmation
	validates_confirmation_of :scorer_password
	

	
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
