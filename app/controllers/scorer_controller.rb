class ScorerController < ApplicationController

  def index
	@rcontests = Regularcontest.all
	@bcontests = Bracketcontest.all
	@contests = Contest.select{ |c| c.date and c.needs_score? and c.date < (Date.today()+1)}
	#@contests = Contest.all
  end

  def record
  end

  def revise
  end
end
