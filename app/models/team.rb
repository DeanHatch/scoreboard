class Team < ActiveRecord::Base
		
	belongs_to :grouping, foreign_key: "grouping_id"
	
	def self.default_comp(comp_id)
		self.default_scope { (where(competition_id: comp_id) ) }
	end
  

end
