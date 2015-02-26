class ResultsController < NestedController # Formerly < ApplicationController
#  before_action :set_competition_from_session, except: [:login]

  def nav_link_array
	  scorer_link_array()
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
  end

  def report
	  @contest = Contest.find(params[:contest_id])
	  @contest.homecontestant.score = params[:homescore]
	  @contest.homecontestant.save
	  @contest.awaycontestant.score = params[:awayscore]
	  @contest.awaycontestant.save
	  @contest.save
	  flash.now[:notice] = 'Wonderful.'
	  redirect_to(:action => "index", notice: 'Wunderbar.')
  end

  def rescord
  end

  def scorect
  end


  private
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
