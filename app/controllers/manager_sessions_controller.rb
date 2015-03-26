class ManagerSessionsController < ApplicationController

	  
  # Link Array. 
  def nav_link_array()
	  session[:manager_id] ?
	  [ navitem('Logout' , :logout_manager) ]  :
	  [ navitem('Login' , :new_manager_session)]
  end
 
	# new action requests prompt page for password.
	# Manager ID must have been supplied.
	# If no password is required then prompt page
	# is skipped and a redirect to either the greeting page
	# or the originally requested page is made.
  def new
	  @manager = Manager.authenticate(params[:manager_id], nil)
	  if @manager
		  session[:manager_id] = @manager.id
		  flash[:notice] = 'Welcome.'
		  redirect_to greet_manager_path
	  end
  end

  def create
	  # manager_id is sent as hidden value on form
	  @manager = Manager.authenticate(login_params[:manager_id],
								login_params[:password])
	  if @manager
		  session[:manager_id] = @manager.id
		  flash[:notice] = 'Welcome.'
		  redirect_to :greet_manager
	  else
		  @manager = Manager.new
		  @manager.errors.add(:password, "is incorrect. Please try again.")
		  flash[:notice] = "Oops... Password is incorrect. Please try again."
		  redirect_to :new_manager_session
	  end
  end

  def logout
	  session[:manager_id] = nil
	  flash[:notice] = 'Bye.'
	  redirect_to :new_manager_session
  end

  private

    # 
  def validate()
	  @manager = Manager.authenticate(params[:manager_id],
								login_params[:password])
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
      params.require(:manager_session).permit(:manager_id, :password)
    end
end
