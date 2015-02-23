class NestedController  < ApplicationController
     before_action :set_competition
     def set_competition
	@competition_id = params[:competition_id]
	return(redirect_to(competitions_url)) unless @competition_id
	begin
	@competition = Competition.find(@competition_id)
	Validdate.default_comp(@competition_id)
	Venue.default_comp(@competition_id)
	Grouping.default_comp(@competition_id)
	Team.default_comp(@competition_id)
	Contest.default_comp(@competition_id)
	Contestant.default_comp(@competition_id)
	Regularcontest.default_comp(@competition_id)
	Regularcontestant.default_comp(@competition_id)
	Bracket.default_comp(@competition_id)
	Bracketcontest.default_comp(@competition_id)
	rescue
	return redirect_to(competitions_url)
	end
    end
end
