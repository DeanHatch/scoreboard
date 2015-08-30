class Bcadvancement < ActiveRecord::Base

  belongs_to :from_contest, class_name: "Bracketcontest",
                                         foreign_key: "from_contest_id"
	
  has_one :bracketcontestant, as: :bcspec
  
  
  def label()
    [self.from_contest.name(),
     self.wl == "W" ? "Winner" : "Loser"].join(' ')
  end
  
  def inspect()
    self.wl.to_s()+'-'+self.from_contest.name()
  end
  
end
