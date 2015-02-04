# Bracketcontest adds functionality related to the contestants.
# Contestants may be winners/losers of prior Bracketcontests,
# for example.
class Bracketcontest < Contest
		
	belongs_to :bracket, foreign_key: "bracket_id"
		
	has_one :homecontestant, -> { where homeaway: 'H' },
						class_name: "Bracketcontestant",
						foreign_key: "contest_id"
	has_one :awaycontestant, -> { where homeaway: 'A' },
						class_name: "Bracketcontestant",
						foreign_key: "contest_id"
	
	validates :competition_id,
		     :bracket_id,
		     :homecontestant,
		     :awaycontestant,
		     presence: true
	
  def self.default_bracket(bracket_id)
   self.default_scope { (where(bracket_id: bracket_id) ) }
  end
  
	
end
