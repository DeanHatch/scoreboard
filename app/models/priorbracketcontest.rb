class Priorbracketcontest < ActiveRecord::Base

  belongs_to :bracketcontest
  has_one :bracketcontestant, as: :bcspec
  
  
  def label()
    [self.bracketcontest.name(),
     self.wl == "W" ? "Winner" : "Loser"].join(' ')
  end
  
  def inspect()
    self.wl.to_s()+'-'+self.bracketcontest.name()
  end
  
end
