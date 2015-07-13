require 'bracket.rb'

class DisplayController < NestedController # Formerly < ApplicationController
     before_action :set_competition

    # Array of Grouping links can have nested Arrays of Grouping links,
    # but it all starts at the top. No navigation if the Competition has not
    # yet been established.
  def nav_link_array()
	  @competition ? nav_link_to_grouping(Grouping.top_grouping) : []
  end
  
	   # (Recursive) The navigation link to this grouping is followed by an Array of
	   # navigation links to each subgrouping within this grouping.
  def nav_link_to_grouping(grp)
	  [navitem(grp.name, display_grouping_path(@competition.id, grp.id))] <<
	    grp.subgroupings.collect{|sg| nav_link_to_grouping(sg)}
  end

  def index
  end

  def team
	  @team = Team.find(params[:id])
	  @groupingteams = Team.where(grouping_id: @team.grouping_id)
	  @groupingteamhash = {}
	  @groupingteams.each{|gt| @groupingteamhash[gt] = gt.as_contestants() }
	  @contestants = @team.as_contestants()
  end

  def grouping
	  @grouping = Grouping.find(params[:id])
	  @groupingteams = Team.where(grouping: @grouping)
	  @contests = @grouping.contests()
	  what2show = params[:xyzzy]
	  if @grouping.bracket_grouping
	    brackets = Bracket.all_for(@grouping)
	    @bracket = brackets.first
	    @bfirst = @bracket.terminalpairing if @bracket
	  end
	  @what_to_render = (case what2show
				when "bracket" 
				  @brackets = Bracket.all_for(@grouping)
 				  @bracketgrouping = Bracketgrouping.find(params[:id])
				  @bracketcontests = Bracketcontest.where(bracketgrouping: @bracketgrouping)
				  logger.info("Bracket Contests: #{@bracketcontests.collect{|bc| bc.id.to_s + bc.name()}.join(' ')}")
				  @priorcontests = Bracketcontestant.where(bracketgrouping: @bracketgrouping).select{|bc| bc.priorcontest()}.collect{|bc| bc.priorcontest()}
				  logger.info("Prior Contests: #{@priorcontests.collect{|bc| bc.id.to_s + bc.name()}.join(' ')}")
				  @terminalcontests = @bracketcontests - @priorcontests
				  logger.info("Terminal Contests: #{@terminalcontests.collect{|bc| bc.id.to_s + bc.name()}.join(' ')}")
				 'grouping_bracket'   
				when "schedule" 
				 @contests = @contests.select{|c| c.needs_score?}.sort
				 'grouping_schedule'   
				when "scores" 
				 @contests = @contests.select{|c| c.has_score?}.sort
				 'grouping_scores'   
				when "standings" 
				 'grouping_standings'   
				else # default if nothing specified 
					@grouping.has_teams? ? 'grouping_standings' : 'grouping_nothing'
				end ) # of case

  end
     
  private
  
     def set_competition
	@competition_id = params[:competition_id]
	super(@competition_id)
	  # If we do not have a valid Competition (e.g. bad bookmark)
	  # then go to root, Welcome page
	return(redirect_to(welcome_index_path)) unless @competition_id
    end

  
end
