#  This class defines a Scorer for the purpose of controlling access to
# the functions for Managing a Competition.  This makes a Scorer
# synonomous with a Competition and facilitates authentication.
class Scorer < Competition
		
	def self.needs_no_authentication(scorerid)
		logger.info("finding Scorer ID: #{scorerid}")
		scorer = self.find(scorerid)
		logger.info("Scorer ID after find: #{scorer.id}")
		  # Return TRUE if Scorer exists and has no password!
		scorer and scorer.hashed_scorer_password.nil?
	end
		
	def self.authenticate(scorerid, scorerpw)
		logger.info("finding Scorer ID: #{scorerid}")
		logger.info("scorerpw: #{scorerpw.inspect()}")
		scorer = self.find(scorerid)
		logger.info("Scorer ID after find: #{scorer.id}")
		  # Skip password check if there is no password!
		return scorer if scorer and scorer.hashed_scorer_password.nil?
		logger.info("hashed scorer pw: #{scorer.hashed_scorer_password.inspect()}")
		if scorer 
			expected_password = encrypted_password(scorerpw, scorer.salt)
			if scorer.hashed_scorer_password != expected_password
				scorer = nil
			end
		end
		scorer # returns a Scorer object or Nil
	end

	
	def scorer_id()
		self.id
	end
	
end
