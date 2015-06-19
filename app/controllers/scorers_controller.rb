class ScorersController < NestedController # Formerly < ApplicationController
  before_action :set_scorer_from_session,
			except: [:choose_customer, :choose_competition]

  def nav_link_array
	  @scorer ? scorer_link_array() : []
  end
  
   
	# Display list of Customers for user to select one
	# unless we ended up here after a Competition has
	# been chosen and the Scorer authenticated.
	# This could happen if the normal sequence of
	# linked pages is not followed (e.g. with a bookmark or the
	# browser's BACK functionality.
     def choose_customer()
       super()
       redirect_to :scorer_index if session[:scorer_id]
    end

     def choose_competition()
       super()
       session[:scorer_id] = nil
    end
 

 
    # Create two lists of Contests, one of Contests with
    # scores and one of Contests without scores.
  def index
	  contests = Contest.all.sort{|a,b| a.id <=> b.id}.
					select {|c| c.homecontestant.team}.
					select {|c| c.awaycontestant.team}
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
	  @contest.homecontestant.score = params[:homescore]
	    # model will handle the details and delegations
	  @contest.record_result(params[:homescore], params[:awayscore])
	  flash.now[:notice] = 'Wonderful.'
	  flash[:notice] = 'Wonderful.'
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
      redirect_to(:action => "choose_customer")
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
