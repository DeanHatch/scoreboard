#  A GameTime is a time of day in five minute increments. An allowable value is "TBD"
#  which means "To Be Determined" and sorts to earlier than any other GameTime.
class GameTime < Object
	
	include Comparable
	
    # Earliest time index
  def self.earliest()
    1
  end
  
    # Latest time index
  def self.latest()
    287
  end
  
	# Create a collection of times throughout the day in five minute increments.
	# This will be used to display starting time choices for schedulers
  def self.times
		# Create a collection of times throughout the day in five minute increments
		# This will be used to display starting time choices for schedulers
    (self.earliest()..self.latest()).to_a.collect {|i| [ GameTime.new(i).to_s, i.to_s ]}
  end
	
    # TBD means ToBeDetermined which we want to sort before any definite time.
  def tbd?()
    @gametimeindex==0
  end
  
    # Store an index value of zero unless we can make sense of whatever string passed in.
  def initialize(whatever)
    @gametimeindex = 
      case
        when whatever.kind_of?(String) then internal_from_string(whatever)
	when whatever.kind_of?(Fixnum)
 	  then (self.class.earliest() .. self.class.latest()) === whatever ? whatever : 0
	else 0
	end
  end
			
    # Equal if indexes are equal.
  def ==(other_gametime)
    @gametimeindex == other_gametime.gametimeindex()
  end
	
    # This is less than other if this index is less than other index.
  def <(other_gametime)
    @gametimeindex < other_gametime.gametimeindex()
  end
	
    # This is greater than other if this index is greater than other index.
  def >(other_gametime)
    @gametimeindex > other_gametime.gametimeindex()
  end
	
    # Compare this index to other index.
  def <=>(other_gametime)
    @gametimeindex <=> other_gametime.gametimeindex()
  end
	
  def self.load(raw)
    self.new(raw)
  end

  def self.dump(gametime)
    gametime.to_s
  end

    # Display "TBD" for unspecified or invalid time.  Display "hh:mm AM/PM" for valid times.
  def to_s
    case @gametimeindex
       # before 1AM
	when 1..11 then ("12:%02d AM" % ((@gametimeindex) * 5))
	    # from 1AM to just before Noon
	when 12..143 then ("%2d:%02d AM" % [(@gametimeindex / 12) , ((@gametimeindex % 12) * 5)])
	    # Noon
	when 144 then "Noon"
       # after noon and before 1PM
	when 145..155 then ("%2d:%02d PM" % [(@gametimeindex / 12) , ((@gametimeindex % 12) * 5)])
	    # after Noon
	when 156..287 then ("%2d:%02d PM" % [(@gametimeindex / 12) - 12 , ((@gametimeindex % 12) * 5)])
	else "TBD"
	end
  end
	
  protected
  
    # Protected so that it is available for comparison purposes
  def gametimeindex()
    @gametimeindex
  end
	
  private
	
    # Convert to the number of discrete five minute intervals since midnight.
    # This breaks string apart into hour, minute, and AM/PM. Another
    # method creates index from constituent parts.
  def internal_from_string(strng)
    # /(\d+):(\d+)\s*([a-zA-Z]\.?[a-zA-Z]\.?)*/ =~ '1:15 pM'
    return 0 if strng.upcase == 'TBD'
    return 0 unless (/(\d+):(\d+)\s*([a-zA-Z]\.?[a-zA-Z]\.?)*/ =~ strng)
    hr = Regexp.last_match(1).to_i
    mn = Regexp.last_match(2).to_i
    ampm = Regexp.last_match(3)
     internal_from_hrmnampm(hr, mn, ampm)
  end

    # First, validate components. Then interpret them into a single index value.
  def internal_from_hrmnampm(hr, mn, ampm)
    raise "Ambiguous Time" if hr < 13 and ampm.nil?
    raise "Military Time Must Not Have AM/PM" if hr > 12 and ampm
    raise "Invalid Time Hour" if hr > 23
    raise "Invalid Time Minute" if mn > 59
    ((ampm and %w(AM A.M.).include?(ampm.upcase) and hr == 12)  ? 0 : hr * 12) +
      ((ampm and %w(PM P.M.).include?(ampm.upcase) and hr < 12)  ? 144 : 0) +
      (mn / 5)
  end
	
end


# Conversion functions
def Gametime(gametime)
  gametime.kind_of?(Gametime) ? gametime : Gametime.new(gametime)
end

def Gamedate(gamedate)
  gamedate.kind_of?(Gamedate) ? gamedate : Gamedate.new(gamedate)
end
