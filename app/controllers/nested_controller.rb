# Controllers which operate on resources nested within Competition inherit
# from this controller class, either directly or indirectly. The primary functionality
# added by this class is to ensure that all activity takes place within a single
# Competition. Two filters are used to achieve this. A before_action ensures
# that a Competition has been specified for all actions except the two involved
# in selecting the Competition. A second before_action filter is used to 
# limit the Competitions available for choosing to only those for a
# single Customer.
class NestedController  < ApplicationController
	# Ensure that a Competition has been specified for all actions
	# except the two involved in selecting the Competition.
     #before_action :set_competition, except: [:choose_customer, :choose_competition]
     #before_action :set_customer, only: [:choose_competition]

     # This specifies the url to redirect to if a Competition
     # has not been specified, or if an invalid Competition 
     # has been specified. That is, the url to redirect to if
     # #set_competition fails. It will be a different redirect
     # for different controllers, so it will be overridden in 
     # descendant classes.
     def failure_redirect()
	competitions_url
	end
  
	# Competitions are nested within Customers. If a subclass of
	# NestedController does not have a Competition specified then
	# the correct response to the request is to prompt for a
	# Customer identifier and then prompt user to choose
	# which of that customer's Competitions to use.
	def choose_customer
	end

	# Once a Customer has been identified, the response prompts
	# the user to choose which of the Customer's Competitions to use.
	def choose_competition
	  logger.info ("Customer ID #{params[:customer_id]} was passed...")
	  Competition.default_cust(params[:customer_id])
	end
	

     # If a Competition has been specified, then set the scope for
     # all nested resources to that Competition.
     def set_competition(competition_id)
	@competition_id = competition_id
	@competition = Competition.find(competition_id)
	rescue 
	return redirect_to(oops_path)
	begin
	Validdate.default_comp(competition_id)
	Venue.default_comp(competition_id)
	Grouping.default_comp(competition_id)
	Team.default_comp(competition_id)
	Contest.default_comp(competition_id)
	Contestant.default_comp(competition_id)
	Regularcontest.default_comp(competition_id)
	Regularcontestant.default_comp(competition_id)
	Bracketgrouping.default_comp(competition_id)
	Bracketcontest.default_comp(competition_id)
	Bracketcontestant.default_comp(competition_id)
	rescue
	return redirect_to(self.failure_redirect)
	end
    end
end
