class ResultsController < NestedController # Formerly < ApplicationController
#  before_action :set_competition_from_session, except: [:login]

  def nav_link_array
	  @competition ? scorer_link_array() : []
  end
  
 

  # GET /customer/login
  # GET /customers.json ??
  def login
  end

  # GET /customer/logout
  # GET /customers.json ??
  def logout
  end
  
    


  def index
	  contests = Contest.all.sort{|a,b| a.id <=> b.id}.
					select {|c| c.homecontestant.team}.
					select {|c| c.awaycontestant.team}
	  @contests_with_scores = contests.select {|c| c.has_score?}
	  @contests_without_scores = contests.select {|c| c.needs_score?}
  end

  def report
	  @contest = Contest.find(params[:contest_id])
	  logger.debug "Converting Contest to: #{@contest.type}"
	  contest_class = Kernel.const_get(@contest.type)
	  @contest = contest_class.find(params[:contest_id])
	  @contest.homecontestant.score = params[:homescore]
	  @contest.record_result(params[:homescore], params[:awayscore])
	  flash.now[:notice] = 'Wonderful.'
	  redirect_to(:action => "index")
  end

  def rescord
  end

  def scorect
  end


  private
 
     def set_customer
	@customer_id = params[:customer_id]
	return(redirect_to(competitions_display_url)) unless @customer_id
	begin
	@customer = Customer.find(@customer_id)
	Competition.default_cust(@customer_id)
	rescue
	return redirect_to(competitions_display_url)
	end
    end
 
    # Use callbacks to share common setup or constraints between actions.
    def set_competition_from_session
      @competition = Competition.find(session[:competition_id])
      rescue
      begin
      @competition = Competition.new()
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def login_params
      params.require("/competition/login").permit(:password)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def competition_params
      params.require("competition").permit(:password)
    end
end