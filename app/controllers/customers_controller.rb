# In the routes file, Customer is a Singular Resource. A Customer establishes a
# Session via a login page/action. Subsequent actions are performed on a
# single Customer, identified by the customer_id in the Session.
class CustomersController < ApplicationController
  before_action :set_customer_from_session, except: [:login, :reset_password]

  
  # Link Array. 
  def nav_link_array()
	  session[:customer_id] ?
	  [ navitem('Change Password' , :change_password_customer),
	     navitem('Edit Profile' , :edit_customer),
	     navitem('Manage Competitions' , :competitions, target: "_blank"),
	     navitem('Logout' , :logout_customer) ]  :
	  [ navitem('Login' , :login_customer),
	     navitem('Register' , :new_customer)]
  end
 

  # GET /customer/login
  # GET /customers.json ??
  def login
	  if request.post?
		  @customer = Customer.authenticate(login_params[:userid], login_params[:password])
		  if @customer
			  session[:customer_id] = @customer.id
			  redirect_to(:action => "greet")
			  else
				  @customer = Customer.new
				  @customer.userid = login_params[:userid]
				  @customer.errors.add(:password, "is incorrect. Please try again.")
				  flash.now[:notice] = 'Oops...'
				  session[:msg] = 'OOPS' + login_params[:userid].inspect() +
				                           login_params[:password].inspect() + 'not helpful'
			  end
		else
			@customer = Customer.new
		end
  end

  # GET /customer/logout
  # GET /customers.json ??
  def logout
	  session[:customer_id] = nil
	  flash.now[:notice] = 'Bye.'
	  redirect_to(:action => "login")
  end

  # GET /customers/1
  # GET /customers/1.json
  def greet
	  Competition.default_cust(@customer.id)
	  @competitions = Competition.all
  end

  # GET /customers/new
  def new
    @customer = Customer.new
  end

  # GET /customer/edit
  def edit
  end

  # GET /customer/change_password
  def change_password
  end

  # POST /customers
  # POST /customers.json
  def create
    @customer = Customer.new(customer_params)

    respond_to do |format|
      if @customer.save
	format.html { session[:customer_id] = @customer.id
			   redirect_to(:action => "greet" ) }
        format.json { render :show, status: :created, location: @customer }
      else
        format.html { render :new }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /customers/1
  # PATCH/PUT /customers/1.json
  def update
	  set_customer_from_session()
    respond_to do |format|
      if @customer.update(customer_params)
        format.html { redirect_to greet_customer_path(@customer), notice: 'Changes made.'}
        format.json { render :show, status: :ok, location: @customer }
      else
        format.html { render :edit }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /customer/new_competition
  def new_competition
	  @competition = Competition.new
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_customer_from_session
      @customer = Customer.find(session[:customer_id])
      rescue
      begin
      @customer = Customer.find(1)
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def login_params
      params.require("/customer/login").permit(:userid, :password)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def customer_params
      params.require("customer").permit(:userid, :password, :password_confirmation, :salt,
							:name, :phone, :website)
    end
end
