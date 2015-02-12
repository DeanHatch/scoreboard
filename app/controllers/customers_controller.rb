class CustomersController < ApplicationController
  before_action :set_customer, only: [:show, :edit, :update, :destroy]

  
  # Link hash. 
  def nav_link_hash()
	  { 'Logout' => :logout_customer} 
  end
  
  # Link options.   Default is new_tab_opts.
  def nav_link_opts()
	  same_tab_opts()
  end

  # GET /customers
  # GET /customers.json
  def index
    @customers = Customer.all
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
  def show
  end

  # GET /customers/1
  # GET /customers/1.json
  def greet
	  set_customer_from_session()
  end

  # GET /customers/new
  def new
    @customer = Customer.new
  end

  # GET /customers/1/edit
  def edit
  end

  # POST /customers
  # POST /customers.json
  def create
    @customer = Customer.new(customer_params)

    respond_to do |format|
      if @customer.save
        format.html { redirect_to @customer, notice: "Customer was successfully created." +
				"#{customer_params[:password]} #{customer_params[:password_confirmation]}" }
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
    respond_to do |format|
      if @customer.update(customer_params)
        format.html { redirect_to @customer, notice: 'Customer was successfully updated.' +
				"PW: #{@customer.password} " +
				"PWC:#{customer_params[:password_confirmation]}" }
        format.json { render :show, status: :ok, location: @customer }
      else
        format.html { render :edit }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /customers/1
  # DELETE /customers/1.json
  def destroy
    @customer.destroy
    respond_to do |format|
      format.html { redirect_to customers_url, notice: 'Customer was successfully destroyed.' }
      format.json { head :no_content }
    end
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

    def set_customer
      @customer = Customer.find(params[:id])
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
      params.require(:customer).permit(:userid, :password, :password_confirmation, :salt)
    end
end
