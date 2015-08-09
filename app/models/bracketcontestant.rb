# A Bracketcontestant will eventually be a Team. However, before a specific Team
# is identified as being the Contestant in a Bracketcontest, the Contestant can be
# generically identified as the Winner or Loser of a prior Bracketcontest or as the 
# nth (e.g. 1st, 2nd,...) Place within some Grouping.
#
# Additionally, a Seeding can be assigned to a Bracketcontestant.  Seeding is
# for informational purposes only.
#
# At any point in time, all of these identifications of a Bracketcontestant 
# are optional.
#
#   Contestanttype Rules (note that this is *distinct* from the STI *type*):
#   Winner/Loser/Place are mutually exclusive.
#   If Winner or Loser are specified, then a Bracketcontest must be.
#   If Place is specified then both a Place and a Grouping must be.
# 
class Bracketcontestant < Contestant
						
	belongs_to :bcspec, polymorphic: true
	
	belongs_to :bracketcontest, foreign_key: "contest_id"

	belongs_to :bracketgrouping, foreign_key: "bracketgrouping_id"

	# Override with additional information.
	def contestanttype
		self.contestantcode.nil? ? nil : self.contestantcode[0]
	end

	
	# Override with automatic save of bcspec, if it exists.
  def save(*)
    super()
    self.bcspec.save if self.bcspec()
  end

						
	# Prior Bracketcontest referred to by this Contestant.
	def priorcontest
		return nil if self.contestantcode.nil?
		case self.contestantcode[0]
			when "W"
				/W(\d+)/ =~ self.contestantcode
				Bracketcontest.find(Regexp.last_match(1))
			when "L"
				/L(\d+)/ =~ self.contestantcode
				Bracketcontest.find(Regexp.last_match(1))
			else 
				nil
			end
	end
						
						
	# Human-readable version of coded Contestant.
	def contestantlabel
		return nil if self.contestantcode.nil?
		case self.contestantcode[0]
			when "W"
				/W(\d+)/ =~ self.contestantcode
				Bracketcontest.find(Regexp.last_match(1)).name + " Winner"
			when "L"
				/L(\d+)/ =~ self.contestantcode
				Bracketcontest.find(Regexp.last_match(1)).name + " Loser"
			when "G" 
				/G(\d+)P(\d+)/ =~ self.contestantcode
				Regexp.last_match(2).to_i.ordinalize + ' Place ' +
					Grouping.find(Regexp.last_match(1)).name
			else 
				nil
			end
	end
						
	# Override with additional information.
	def fullname
		[(self.seeding ? '#' + (self.seeding.to_s) : nil) ,
		self.contestantlabel,
		 self.teamname()].join(' ')
	end
						
	# Provide conditional information.
	def briefname()
	  case
 	    when self.team() then self.teamname()
	    when self.contestantlabel() then self.contestantlabel()
	    when self.seeding() then ('#' + (self.seeding().to_s))
	    else "TBD"
	  end
	end
  
end
