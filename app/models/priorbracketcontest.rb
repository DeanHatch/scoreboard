class Priorbracketcontest < ActiveRecord::Base

  belongs_to :bracketcontest
  has_one :bracketcontestant, as: :bcspec
  
  def inspect()
    self.wl.to_s()+'-'+self.bracketcontest.name()
  end
  
end
