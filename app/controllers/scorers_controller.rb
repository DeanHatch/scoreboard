class ScorersController < NestedController # Formerly < ApplicationController
  before_action :set_scorer_from_session

  def nav_link_array
	  @scorer ? scorer_link_array() : []
  end
  
   

    # Create two lists of Contests, one of Contests with
    # scores and one of Contests without scores.
  def index
    logger.debug "GGGGGGGGGetting Contests for Scorer: #{@scorer.id}"
    contests = @scorer.contests.
					select {|c| c.homecontestant.team}.
					select {|c| c.awaycontestant.team}.
					sort{|a,b| a <=> b}   # present in chronological order
    logger.debug "GGGGGGGGGot Em"
    @contests_with_scores = contests.select {|c| c.has_score?}
    @contests_without_scores = contests.select {|c| c.needs_score?}
  end

    # PATCH for reporting a score or correcting a score.
    # Note that we can report the score of any type of
    # Contest, so one of the first things we need to do is
    # to determine the correct subclass of Contest.
  def report
	  @contest = Contest.find(params[:contest_id])
	  logger.debug "Converting Contest to: #{@contest.type}"
	  contest_class = Kernel.const_get(@contest.type)
	  @contest = contest_class.find(params[:contest_id])
	  #@contest.homecontestant.score = params[:homescore]
	    # model will handle the details and delegations
	  begin
	  @contest.record_result(params[:homescore], params[:awayscore])
	  flash.now[:notice] = 'Wonderful.'
	  flash[:notice] = 'Wonderful.'
	  rescue StandardError => e
	  flash.now[:notice] = 'Oops! Something was wrong with that score.  ' + e.message
	  flash[:notice] = 'Oops! Something was wrong with that score.  ' + e.message
	  end
	  redirect_to(:action => "index")
  end

  
  private
 
    # Use callbacks to share common setup or constraints between actions.
    def set_scorer_from_session
      @scorer = Scorer.find(session[:scorer_id])
      rescue
      begin
        logger.info("Scorer #{session[:scorer_id]} not found...")
      @scorer = Scorer.new()
      redirect_to oops_path
      end
    logger.info("Scorer #{session[:scorer_id]} WAS found...")
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def login_params
      params.require("/scorer/login").permit(:password)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def scorer_params
      params.require("scorer").permit(:password)
    end
end
