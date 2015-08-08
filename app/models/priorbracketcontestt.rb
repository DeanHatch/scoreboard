class Priorbracketcontest < ActiveRecord::Base

  self.primary_key = "bracketcontest_id"
  
  belongs_to :bracketcontest, foreign_key: "bracketcontest_id"
  
  validates :wl, inclusion: { in: %w(W,L),
    message: "%{value} must be W or L" }
  
end