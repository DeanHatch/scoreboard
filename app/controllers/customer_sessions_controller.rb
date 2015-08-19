class CustomerSessionsController < ApplicationController
	
 
	  
  # Link Array. 
  def nav_link_array()
	  session[:customer_id] ?
	  [ navitem('Logout' , :logout_customer_session) ]  :
	  [ navitem('Login' , :new_customer_session),
	     navitem('Register' , :new_customer)]
  end
 


  # Prompts the Customer for ID and Password.
  # The ID and Password will be used to authenticate the Customer.
  def new
	  @customer = Customer.new
	  @customer.userid = flash[:userid] if flash[:userid]
  end

  def create
	  @customer = Customer.authenticate(login_params[:userid], login_params[:password])
	  if @customer
		  session[:customer_id] = @customer.id
		  redirect_to :greet_customer
	  else
		  @customer = Customer.new
		  @customer.userid = login_params[:userid]
		  @customer.errors.add(:password, "is incorrect. Please try again.")
		  flash[:userid] = login_params[:userid]
		  flash[:notice] = "Incorrect Userid or Password"
		  redirect_to new_customer_session_path(@customer)
	  end
  end


  def logout
	  session[:customer_id] = nil
	  flash[:notice] = 'Bye.'
	  redirect_to :new_customer_session
  end

  
  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def login_params
      params.require(:customer_session).permit(:userid, :password)
    end
end
