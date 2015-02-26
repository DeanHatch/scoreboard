class DisplayController < NestedController # Formerly < ApplicationController
     before_action :set_competition, except: [:choose_customer, :choose_competition]
     before_action :set_customer, only: [:choose_competition]

    # Array of Grouping links can have nested Arrays of Grouping links,
    # but it all starts at the top. No navigation if the Competition has not
    # yet been established.
  def nav_link_array()
	  @competition ? nav_link_to_grouping(Grouping.top_grouping) : []
  end
  
	   # (Recursive) The navigation link to this grouping is followed by an Array of
	   # navigation links to each subgrouping within this grouping.
  def nav_link_to_grouping(grp)
	  [navitem(grp.name, ryandog_path(@competition.id, grp.id))] <<
	    grp.subgroupings.collect{|sg| nav_link_to_grouping(sg)}
  end
  

  def choose_customer
  end

  def choose_competition
  end

  def index
  end

  def teams
	  @teams = Team.all
	  #Regularcontest.all.select{|rc| rc.homecontestant.nil?}.each{|rc| rc.destroy}
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
	  @groupingteams = Team.where(grouping_id: @grouping.id)
	  @whatsit = params[:xyzzy]
	  if @grouping.bracket_grouping		  
		  @bracket = Bracket.find(params[:id])
		  @bracketcontests = Bracketcontest.where(bracket_id: @bracket.id)
	  end
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

     def set_navigation
	@customer_id = params[:customer_id]
	return(redirect_to(competitions_display_url)) unless @customer_id
	begin
	@customer = Customer.find(@customer_id)
	Competition.default_cust(@customer_id)
	rescue
	return redirect_to(competitions_display_url)
	end
    end

end
