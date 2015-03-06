class ManagerController < NestedController  # formerly ApplicationController
  before_action :validate_competition, except: [:login]

  def nav_link_array()
	manager_link_array()
  end

  def login()
			  session[:competition_id] = @competition.id
			  redirect_to(:action => "index")
	  if request.post?
		  @competition = Competition.authenticate(login_params[:password])
		  if @competition
			  session[:competition_id] = @competition.id
			  redirect_to(:action => "index")
			  else
				  @competition = Competition.new
				  @competition.errors.add(:password, "is incorrect. Please try again.")
				  flash.now[:notice] = 'Oops...'
			  end
		else
			@competition = Competition.new
		end
	end
	

  def choose_customer()
  end

  def choose_competition()
  end
	
  def index()
  end
  


 private
 
  def validate_competition()
	  #session[:competition_id] = @competition.id
	  #redirect_to( :action => "login") if params[:competition_id] != session[:competition_id]
  end
 
end
