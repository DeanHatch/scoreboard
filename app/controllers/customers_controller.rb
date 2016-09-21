# 
# 
# 
class CustomersController < ApplicationController
  before_action :set_customer_from_session

  # Use this Link Array when Customer is both Confirmed and Logged In. 
  def fullnav()
      [navitem('Edit Profile' , :edit_customer),
	     navitem('Create a New Competition' , :new_competition_customer),
	     navitem('Manage My Competitions' , choose_competition_manager_path(@customer), target: "_blank") ] 
  end
  
  
    # Only display navigation links if we are working
    # within a Competition. If we are still selecting
    # the Competition, do not display navigation.
  def nav_link_array()
	current_customer ? [navitem('Update Profile' , edit_customer_path()),
					navitem('Log Out' , customer_sign_out_path())] :
				    [navitem('Customer Log In' , new_customer_session_path())]
  end


  # GET /customer
  def show
    flash[:notice] = 'You can click on an action on the left.'
  end

   
  # GET /customer/edit
  def edit
    flash[:notice] = 'Type your changes below. Then just press ENTER or click on the Update button to save your changes.'
  end


  # PATCH/PUT /customers/1
  def update
    respond_to do |format|
      if @org.update(organization_params)
	flash[:notice] = 'Changes made.'
        format.html { redirect_to customer_path}
      else
        format.html { render :edit }
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
  

  private


    # Never trust parameters from the scary internet, only allow the white list through.
    def customer_params
      params.require(:customer).permit(:userid, :name, :phone, :website)
    end


    # Never trust parameters from the scary internet, only allow the white list through.
    def competition_params
      params.require(:competition).permit(:name, :sport, :variety, :poolgroupseason, :poolgroupseasonlabel, :playoffbracket, :playoffbracketlabel, :keepscores, :winpoints, :drawpoints, :losspoints, :forfeitpoints, :forfeitwinscore, :forfeitlossscore)
    end

    def organization_params
      params.require(:organization).permit(:name, :phone, :website)
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_customer_from_session
      redirect_to new_customer_session_path() unless current_customer
      @cust = current_customer
      @org = @cust.organization if @cust
    end

end
