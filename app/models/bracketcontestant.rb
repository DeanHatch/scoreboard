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
  	  case self.bcspec_type
	    when "Groupingplace"
	      "G"
	    when "Bcadvancement"
	      self.bcspec.wl
	    else
	      self.bcspec.class.name
	  end
	end

    # Accessor
  def contestantcode
    case self.bcspec_type
      when "Groupingplace"
        ("G" + self.bcspec.grouping.id.to_s + "P" + self.bcspec.place.to_s ) 
      when "Bcadvancement"
	(self.bcspec.wl + self.bcspec.from_contest.id.to_s)
      end
  end
  
    # Accept code and interpret it
  def contestantcode=(ccode)
    self.bcspec.destroy() if self.bcspec
    case ccode[0]
      when "G"
        self.bcspec = Groupingplace.new()
	/G(\d+)P(\d+)/ =~ ccode
	self.bcspec.grouping = Grouping.find(Regexp.last_match(1))
	self.bcspec.place = Regexp.last_match(2)
	puts "*   * *  * * * * *  GroupingPlaceCode " + ccode
      when "W"
        self.bcspec = Bcadvancement.new()
        /W(\d+)/ =~ ccode
        self.bcspec.from_contest = Bracketcontest.find(Regexp.last_match(1))
        self.bcspec.wl = "W"
      when "L"
        self.bcspec = Bcadvancement.new()
        /L(\d+)/ =~ ccode
        self.bcspec.from_contest = Bracketcontest.find(Regexp.last_match(1))
        self.bcspec.wl = "L"
      else 
        nil
    end
  end
	
	# Override with automatic save of bcspec, if it exists.
  def save(*)
    super()
    self.bcspec.save if self.bcspec()
  end
	
	# Override with automatic save of bcspec, if it exists.
  def save!(*)
    super
    self.bcspec.save! if self.bcspec()
  end

						
	# Prior Bracketcontest referred to by this Contestant.
	# This acts as a "through" association shortcut, of sorts.
  def priorcontest
    return nil if self.bcspec.nil?
    self.bcspec_type == "Bcadvancement" ? self.bcspec.from_contest : nil
  end
	
    # 	
  def bracketdepth()
    self.priorcontest ? self.priorcontest.bracketdepth() : 1
  end  
						
	# Human-readable version of coded Contestant.
  def contestantlabel
    self.bcspec ? self.bcspec.label() : " "
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
