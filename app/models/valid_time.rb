class ValidTime < ActiveRecord::Base
	
  belongs_to :competition, foreign_key: "competition_id"
  belongs_to :manager, foreign_key: "competition_id"
  validates_presence_of :competition_id

  def grouping()
    self.grouping_id ? Grouping.find(self.grouping_id).fullname : 'All'
  end

  def venue()
    self.venue_id ? Venue.find(self.venue_id).name : 'All'
  end
	
  def self.default_comp(comp_id)
    self.default_scope { (where(competition_id: comp_id) ) }
  end
  
  def display_from_time
    GameTime.new(self.from_time).to_s
  end
  
  def display_to_time
    GameTime.new(self.to_time).to_s
  end

end
