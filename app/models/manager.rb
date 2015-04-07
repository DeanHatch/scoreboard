#  This class defines a Manager for the purpose of controlling access to
# the functions for Managing a Competition.  This makes a Manager
# synonomous with a Competition and facilitates authentication.
class Manager < Competition
		
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

	
	def manager_id()
		self.id
	end
	
end
