class DisplayController < NestedController # Formerly < ApplicationController
	
  def index
  end

  def teams
	  @teams = Team.all
	  #Regularcontest.all.select{|rc| rc.homecontestant.nil?}.each{|rc| rc.destroy}
  end

  def team
	  @team = Team.find(params[:id])
	  @groupingteams = Team.where(grouping_id: @team.grouping_id)
	  #@regularcontestants = Regularcontestant.where(team_id: params[:id])
	  @contestants = Contestant.where(team_id: params[:id])
  end

  def grouping
  end
end
