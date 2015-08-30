#  This class defines a Bracketgrouping for the purpose of collecting Bracketcontests.
#  A Bracketgrouping is a Grouping that has its bracket_grouping value set to true.
#  Each Bracketgrouping is the Grouping within which the Bracketcontests will be played.
class Bracketgrouping < Grouping
	
	has_many :bracketcontests
	has_many :bracketcontestants, through: :bracketcontests
	has_many :bcadvancements, through: :bracketcontests
	
	def Bracketgrouping.alll()
		super.where(bracket_grouping: true)
	end
	
	def all_participant_codes()
		apc = Hash.new
		Bracketcontest.where(bracketgrouping: self).
				each{|bc| apc[bc.name + ' Winner']="W#{bc.id}";
						apc[bc.name + ' Loser']="L#{bc.id}"}
		(self.all_subgroupings << self).select{|g|g.has_teams?}.
		     each{|g|(1..g.teams.count).
				each{|p| apc[p.ordinalize+' Place '+g.name]="G#{g.id}P#{p}"}}
		apc
	end
	
    
     # Complete SingleElimination Matchups.
     # Number of seeds is number of Teams in this Bracketgrouping
    def complete_se_matchups()
      for_pair(se_matchups(self.all_teams.size()))
    end
    
     # SingleElimination Matchups. Takes the number of seeds (i.e. Teams)
    def se_matchups(numseeds)
      seeds = (1..numseeds).to_a
      numrounds = Math.log2(numseeds).ceil
      matchups = (1...numrounds).inject(seeds) do |memo, unused|
        lpot = 2 ** (Math.log2(memo.size).ceil - 1)
        top_half = memo[0, lpot]
        bottom_half = memo[lpot..(memo.size - 1)]
        top_half.reverse.zip(bottom_half).reverse
      end
   end

  
    # 
  def for_pair(bc_array)
    bracketcontest = Bracketcontest.new() # also creates Bracketcontestants
    bracketcontest.bracketgrouping = self
    bracketcontest.homecontestant.bracketgrouping = self
    bracketcontest.awaycontestant.bracketgrouping = self
    bracketcontest.competition = self.competition
    bracketcontest.status = 'SCHEDULED'
      # Assign Home Contestant.
      # It may be a seeding number or a Winner of a prior Bracketcontest
    assign_seeding_and_ccode(bracketcontest.homecontestant, bc_array[0])
      # Assign Away Contestant.
      # It may also be a seeding number or a Winner of a prior Bracketcontest
    assign_seeding_and_ccode(bracketcontest.awaycontestant, bc_array[1])
    bracketcontest.name = 'Game ' + self.game_number.to_s
    bracketcontest.save_all! ? bracketcontest : nil  # returns nil if not saved
  end

  def game_number()
    @game_number ||= 0
    @game_number += 1
    #@game_number
  end
  
    # 
  def assign_seeding_and_ccode(bc, seed_or_pair)
    bc.seeding = seed_or_pair if seed_or_pair.class == Fixnum
      # If Array passed, then either get winner of the Bracketcontest it represents
      # or snatch the seeding from it if it is a seeding versus nil (i.e. BYE)
    if seed_or_pair.class == Array
      bc.contestantcode = for_pair(seed_or_pair).winner_code() if seed_or_pair[0..1].compact.size() == 2
      bc.seeding = seed_or_pair[0..1].compact.first() if seed_or_pair[0..1].compact.size() == 1
    end
  end

end
