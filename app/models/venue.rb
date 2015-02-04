class Venue < ActiveRecord::Base
		
	def self.default_comp(comp_id)
		self.default_scope { (where(competition_id: comp_id) ) }
	end
  

end
