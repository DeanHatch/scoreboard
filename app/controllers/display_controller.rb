class DisplayController < ApplicationController
  def index
	@rcontests = Regularcontest.all
	@bcontests = Bracketcontest.all
	@contests = Contest.all
  end

  def team
	set_team()
  end

  def grouping
	set_grouping()
	@contests = Contest.all
	@teams = @grouping.teams
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_team
      @team = Team.find(params[:id]) if Team.exists?(params[:id])
    end

    def set_grouping
      Grouping.exists?(params[:id]) ? @grouping = Grouping.find(params[:id]) :
					@grouping = ( Grouping.exists?(1) ? Grouping.find(1) : nil)
    end

  
    # Never trust parameters from the scary internet, only allow the white list through.
    def valid_params
      params.permit(:id)
    end

end
