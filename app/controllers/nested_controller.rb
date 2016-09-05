# Controllers which operate on resources nested within Competition inherit
# from this controller class, either directly or indirectly. The primary functionality
# added by this class is to ensure that all activity takes place within a single
# Competition. Two filters are used to achieve this. A before_action ensures
# that a Competition has been specified for all actions except the two involved
# in selecting the Competition. A second before_action filter is used to 
# limit the Competitions available for choosing to only those for a
# single Organization.
class NestedController  < ApplicationController
	# Ensure that a Competition has been specified for all actions
	# except the two involved in selecting the Competition.
     #before_action :set_competition, except: [:choose_organization, :choose_competition]
     #before_action :set_organization, only: [:choose_competition]

     # This specifies the url to redirect to if a Competition
     # has not been specified, or if an invalid Competition 
     # has been specified. That is, the url to redirect to if
     # #set_competition fails. It will be a different redirect
     # for different controllers, so it will be overridden in 
     # descendant classes.
     def failure_redirect()
	competitions_url
	end
  

     # If a Competition has been specified, then set the scope for
     # all nested resources to that Competition.
     def set_competition(competition_id)
	@competition_id = competition_id
	@competition = Competition.find(competition_id)
	rescue 
	return redirect_to(oops_path)
	begin
	rescue
	return redirect_to(self.failure_redirect)
	end
    end
end
