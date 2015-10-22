
class DisplayController < NestedController # Formerly < ApplicationController
     before_action :set_competition

    # Array of Grouping links can have nested Arrays of Grouping links,
    # but it all starts at the top. No navigation if the Competition has not
    # yet been established.
  def nav_link_array()
	  @competition ? nav_link_to_grouping(@competition.top_grouping) : []
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
    @groupingteams.each{|gt| @groupingteamhash[gt] = gt.contestants() }
    @contestants = @team.contestants()
    @scores = @contestants.select{|c| c.contest.has_score?}.sort{|a,b| a.contest <=> b.contest}
  end

  def alert_request
    @team = Team.find(params[:id])
    @alert_request = AlertRequest.new()
  end

  def set_alert
    params.require(:alert).permit(:emailaddr, :to_dest, :mobile_carrier)
    @team = Team.find(params[:id])
    alert = params[:alert]
    emailaddr = params.require(:alert)[:emailaddr]
    to_dest = params.require(:alert)[:to_dest]
    mobile_carrier = params.require(:alert)[:mobile_carrier]
    logger.info("*** Setting Alert: #{@team.inspect()}")
    logger.info("            alert: #{alert.inspect()}")
    logger.info("        emailaddr: #{emailaddr}")
    logger.info("          to_dest: #{to_dest}")
    logger.info("   mobile_carrier: #{mobile_carrier}")
    if not mobile_carrier.blank? or not to_dest.blank?
      if @team.alert_requests.create(type: "SMSAlert",
							to_dest: to_dest,
							at_domain: mobile_carrier).valid?
        flash[:notice] = 'SMS Notification Request Processed.'
      else
        flash[:alert] = 'Unable to Create SMS Notification Request.'
      end
    end
    if not emailaddr.blank?
      @team.email_alerts.create!(type: "EmailAlert",
					    to_dest: to_dest,
					    at_domain: emailaddr) 
    end
  end

  def grouping
	  @grouping = Grouping.find(params[:id])
	  @groupingteams = Team.where(grouping: @grouping)
	  @contests = @grouping.unique_contests()
	  @bracketgrouping = Bracketgrouping.find(params[:id])
	  @bracketcontests = @bracketgrouping.bracketcontests
	  what2show = params[:xyzzy]
	  @what_to_render = (case what2show
				when "bracket" 
				  @priorcontests = @bracketgrouping.bcadvancements.collect{|pbc| pbc.from_contest}
				  @terminalcontests = @bracketcontests - @priorcontests
				  logger.info("*** Terminal Contests: #{@terminalcontests.collect{|bc| bc.id.to_s + bc.name()}.join(' ')}")
				 'grouping_bracket'   
				when "schedule" 
				 @contests = @contests.select{|c| c.needs_score?}.sort
				  logger.info("*** Scheduled Contests: #{@contests.collect{|bc| bc.id.to_s}.join(' ')}")
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
