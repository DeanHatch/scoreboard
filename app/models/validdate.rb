class Validdate < ActiveRecord::Base
	
	belongs_to :competition, foreign_key: "competition_id"
	validates_presence_of :competition_id
	
  def self.default_comp(comp_id)
	  self.default_scope { (where(competition_id: comp_id) ) }
  end
  

end
