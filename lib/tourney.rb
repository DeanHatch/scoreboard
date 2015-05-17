#! /usr/bin/env ruby

class Array
  def half_size; size >> 1; end
  def top_half; self[0, half_size]; end
  def bottom_half; self[half_size, half_size]; end
end

class Tournament
  def initialize(players)
    #raise "Tournament requires 2 or more players" if players.size < 2

    @players = players
    @matches = (0...nrounds).inject(seed) do |memo, unused|
      memo.top_half.zip(memo.bottom_half.reverse)
    end
  end

  attr_reader :players
  attr_reader :matches

  protected
  def seed; @seed ||= players + Array.new(nbyes, :bye); end
  def nplayers; players.size; end
  def nrounds; Math.log2(nplayers).ceil; end
  def nbyes; (1 << nrounds) - nplayers; end
end

puts Tournament.new([:a, :b, :c, :d, :e, :f, :g, :h, :i]).matches.inspect()

puts  Tournament.new((1..7).to_a).matches.inspect()

     # SingleElimination Matchups. Takes the number of seeds (i.e. Teams)
    def se_matchups(numseeds)
      seeds = (1..numseeds).to_a
      numrounds = Math.log2(numseeds).ceil
      matchups = (0...numrounds).inject(seeds) do |memo, unused|
        lpot = 2 ** (Math.log2(memo.size).ceil - 1)
        top_half = memo[0, lpot]
        bottom_half = memo[lpot..(memo.size - 1)]
        top_half.reverse.zip(bottom_half).reverse
      end
   end
  
  se_matchups(5)
  
  p se_matchups(7)
  p se_matchups(8)
  p se_matchups(9)
  p se_matchups(16)
  
  if 7<12
    p "less than"
    i = 2
    end
    