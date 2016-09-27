# Manager controller classes inherit from this class.
class ManagersController < NestedController

     before_action :check_manager_session

    # Only display navigation links if we are working
    # within a Competition. If we are still selecting
    # the Competition, do not display navigation.
  def nav_link_array()
	#@competition ? manager_link_array() : []
	session[:manager_id] ? manager_link_array() : []
  end
  
  # Display page where Manager can set or clear
  # either the Manager Password or the Scorer Password.
  def passwords()
  end
  
  # Assign the Manager Password if it passes Validations.
  def change_manager_password()
	  #manager_pw_params
	  respond_to do |format|
	    @manager.update(manager_pw_params)
	    if @manager.valid?
		  #if @manager.update!(manager_pw_params)
			  flash[:notice] = 'Change made.'
			  format.html { redirect_to :action => "greet"}
			  else
				  flash[:notice] = 'Change NOT made.'
				  @manager.errors.full_messages.each do |msg|
				    flash[:alert] = msg
				  end
				  format.html { redirect_to :action => "passwords" }
			  end
		  end
 end
  
  # Set Manager Password to NIL.
  def clear_manager_password()
	  @manager.clear_manager_password()
	  respond_to do |format|
		  if @manager.save!()
			  flash[:notice] = 'Change made.'
			  format.html { redirect_to :action => "greet"}
			  else
				  flash[:notice] = 'Change NOT made.'
				  format.html { redirect_to :action => "passwords" }
			  end
		  end
 end
  
  # Assign the Scorer Password if it passes Validations.
  def change_scorer_password()
	respond_to do |format|
		if @manager.update!(scorer_pw_params)
			  flash[:notice] = 'Change made.'
			format.html { redirect_to :action => "greet"}
		else
			flash[:notice] = 'Change NOT made.'
			format.html { redirect_to :action => "passwords" }
		end
	end
  end
  
  # Set Scorer Password to NIL.
  def clear_scorer_password()
    @manager.clear_scorer_password()
    respond_to do |format|
      if @manager.save!()
        flash[:notice] = 'Change made.'
        format.html { redirect_to :action => "greet"}
      else
	flash[:notice] = 'Change NOT made.'
	format.html { redirect_to :action => "passwords"}
      end
   end
 end
  
	
  # Initial page.
  def greet()
  end
  


 private

  def check_manager_session()
	  logger.info("Manager ID from session is: #{session[:manager_id].inspect()}")
	  if session[:manager_id].nil?
		  redirect_to oops_path
	  else
	    begin
	    @manager = Manager.find(session[:manager_id])
	    rescue
	      session[:manager_id] = nil
	      redirect_to oops_path
	    end
	  end
  end
 
    # Manager Password arrives with a Confirmation.
    def manager_pw_params
      params.require(:manager).permit(:manager_password, :manager_password_confirmation)
    end

    # Scorer Password arrives with a Confirmation.
    def scorer_pw_params
      params.require(:manager).permit(:scorer_password, :scorer_password_confirmation)
    end
 
end
