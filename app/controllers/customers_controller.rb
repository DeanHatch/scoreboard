# In the routes file, Customer is a Singular Resource. A Customer establishes a
# Session via a login page/action. Subsequent actions are performed on a
# single Customer, identified by the customer_id in the Session.
class CustomersController < ApplicationController
  before_action :set_customer_from_session, except: [:new, :create, :confirm, :reset_password]

  def fullnav()
      [ navitem('Change Password' , :change_password_customer),
	     navitem('Edit Profile' , :edit_customer),
	     navitem('Create a New Competition' , :new_competition_customer),
	     navitem('Manage My Competitions' , choose_competition_manager_path(@customer), target: "_blank"),
	     navitem('Logout' , :logout_customer_session) ] 
  end

  def unconfirmed()
      [ navitem('Logout' , :logout_customer_session) ] 
  end

  def loggedout()
      [ navitem('Logout' , :logout_customer_session) ] 
  end
  
  # Link Array. 
  def nav_link_array()
        # Can be one of three states: 1) logged-in and confirmed, 2) logged-in and unconfirmed, 3) not logged in.
    session[:customer_id] ? 
          (Customer.find(session[:customer_id]).confirmed? ? fullnav() : unconfirmed()) :
	   loggedout()
  end
 

  # GET /customers/1
  # GET /customers/1.json
  def greet
    Competition.default_cust(@customer.id)
    @competitions = Competition.all
    flash[:notice] = 'You need to confirm your Registration.' unless @customer.confirmed?
  end

  # GET /customers/new
  def new
    @customer = Customer.new
  end

  # GET /customer/edit
  def edit
  end

  # POST /customers
  def create
    @customer = Customer.new(customer_params)

    respond_to do |format|
      if @customer.save
        #CustomerMailer.welcome(@customer.userid).deliver_later
	CustomerEmailer.welcome(@customer).deliver
	session[:customer_id] = @customer.id
	format.html {  redirect_to greet_customer_path }
      else
        format.html { render :new }
      end
    end
  end

  # GET /customer/:id/confirm/:reg_confirm_token
  def confirm
    respond_to do |format|
      @customer = Customer.find(params[:id])
      if @customer.reg_confirm_token == params[:reg_confirm_token]
        session[:customer_id] = @customer.id
        @customer.reg_confirm_token = nil
        @customer.save!()
        format.html {redirect_to(:action => "greet" ) }
        else
         format.html {  redirect_to greet_customer_path }
      end
    end
  end

  # PATCH/PUT /customers/1
  def update
    respond_to do |format|
      if @customer.update(customer_params)
	flash[:notice] = 'Changes made.'
        format.html { redirect_to greet_customer_path}
      else
        format.html { render :edit }
      end
    end
  end

  # GET /customer/change_password
  def change_password
  end

  # PATCH/PUT /customers/1
  def update_password
    respond_to do |format|
      if @customer.update(customer_params)
	      flash[:notice] = 'Password CHANGED!'
	      format.html { redirect_to greet_customer_path}
      else
	      flash[:notice] = 'Password NOT Changed!!!'
	      format.html { render :change_password }
      end
    end
  end

  # GET /customer/new_competition
  def new_competition
	  @competition = Competition.new
  end


  # POST /customer/create_competition
  def create_competition
	  @competition = Competition.new(competition_params)
	  @competition.customer = @customer
	  respond_to do |format|
		  if @competition.save
			  flash[:notice] = 'You have a New Competition'
			  format.html { redirect_to(:action => "greet" ) }
		else
			format.html {  redirect_to(:action => "new_competition") }
		end
	end
  end


  def logout
	  session[:customer_id] = nil
	  flash.now[:notice] = 'Bye.'
	  redirect_to :new_customer_session
  end
  

  private
  
  
    # Use callbacks to share common setup or constraints between actions.
    def set_customer_from_session
      @customer = Customer.find(session[:customer_id])
      rescue
      begin
	@customer = Customer.new
	#@customer = Customer.find(1)
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def new_customer_params
      params.require(:customer).permit(:userid, :password, :password_confirmation)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def customer_params
      params.require(:customer).permit(:userid, :password, :password_confirmation,
							:name, :phone, :website)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def confirm_params
      params.require(:customer).permit(:reg_confirm_token)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def competition_params
      params.require(:competition).permit(:name, :sport, :variety, :poolgroupseason, :poolgroupseasonlabel, :playoffbracket, :playoffbracketlabel, :keepscores, :winpoints, :drawpoints, :losspoints, :forfeitpoints, :forfeitwinscore, :forfeitlossscore)
    end

end
