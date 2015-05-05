class ManagerSessionsController < ApplicationController

	  
  # Link Array. 
  def nav_link_array()
	  session[:manager_id] ?
	  [ navitem('Logout' , :logout_manager) ]  :
	  [ navitem('Login' , :login_manager_session)]
  end
 
	# new action requests prompt page for password.
	# Manager ID must have been supplied.
	# If no password is required then prompt page
	# is skipped and a redirect to either the greeting page
	# or the originally requested page is made.
  def new
    @manager_id = params[:manager_id]
    if Manager.needs_no_authentication(@manager_id)
      session[:manager_id] = @manager_id
      flash[:notice] = 'Welcome.'
      redirect_to greet_manager_path
    else
      @manager = Manager.find(@manager_id)
    end
  end

  def create
	  # manager_id is sent as hidden value on form
	  @manager = Manager.authenticate(login_params[:manager_id],
								login_params[:manager_password])
	  if @manager
		  session[:manager_id] = @manager.id
		  flash[:notice] = 'Welcome.'
		  redirect_to :greet_manager
	  else
		  @manager = Manager.new
		  @manager.errors.add(:password, "is incorrect. Please try again.")
		  flash[:notice] = "Oops... Password is incorrect. Please try again."
		  redirect_to  login_manager_session_path(login_params[:manager_id]) 
	  end
  end

  def logout
	  session[:manager_id] = nil
	  flash[:notice] = 'Bye.'
	  #redirect_to :login_manager_session
	  redirect_to :root
  end

  private

    # 
  def validate()
	  @manager = Manager.authenticate(params[:manager_id],
								login_params[:manager_password])
	  if @manager
		  session[:manager_id] = @manager.id
		  flash[:notice] = 'Welcome.'
		  redirect_to(:action => "greet")
	  else
		  @manager = Manager.new
		  @manager.errors.add(:password, "is incorrect. Please try again.")
		  flash[:notice] = 'Oops...'
		  redirect_to :new_manager_session
	  end
  end

    # Never trust parameters from the scary internet, only allow the white list through.
    def login_params
      params.require(:manager_session).permit(:manager_id, :manager_password)
    end
end
