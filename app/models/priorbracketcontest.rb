class Priorbracketcontest < ActiveRecord::Base

  belongs_to :bracketcontest
  has_one :bracketcontestant, as: :bspec
  
  def inspect()
    self.wl.to_s()+'-'+self.bracketcontest.id.to_s()
  end
  
end
