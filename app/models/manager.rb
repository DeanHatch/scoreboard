#  This class defines a Manager for the purpose of controlling access to
# the functions for Managing a Competition.  This makes a Manager
# synonomous with a Competition and facilitates authentication.
class Manager < Competition
		
	def self.needs_no_authentication(mgrid)
		logger.info("finding Mgr ID: #{mgrid}")
		mgr = self.find(mgrid)
		logger.info("Mgr ID after find: #{mgr.id}")
		  # Return TRUE if Manager exists and has no password!
		mgr and mgr.hashed_manager_password.nil?
	end
		
	def self.authenticate(mgrid, mgrpw)
		logger.info("finding Mgr ID: #{mgrid}")
		logger.info("mgrpw: #{mgrpw.inspect()}")
		mgr = self.find(mgrid)
		logger.info("Mgr ID after find: #{mgr.id}")
		  # Skip password check if there is no password!
		return mgr if mgr and mgr.hashed_manager_password.nil?
		logger.info("hashed manager pw: #{mgr.hashed_manager_password.inspect()}")
		if mgr 
			expected_password = encrypted_password(mgrpw, mgr.salt)
			if mgr.hashed_manager_password != expected_password
				mgr = nil
			end
		end
		mgr # returns a Manager object or Nil
	end

	  # Is this needed?
	def manager_id()
		self.id
	end
	

	  # Is this needed?
	def conpetition_id()
		self.id
	end
	

	  # Re-cast to inherited class
	def as_competition()
		self.becomes(Competition)
	end
	
end
