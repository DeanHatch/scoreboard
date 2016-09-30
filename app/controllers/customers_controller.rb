# 
# 
# 
class CustomersController < ApplicationController
  before_action :set_customer_from_session

    # Array of Navigation links to display dependent
    # on whether Customer is logged in or not.
  def nav_link_array()
	current_customer ? [navitem('Update Profile' , edit_customer_path()),
	                               navitem('New Competition', new_competition_customer_path()),
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


  # PATCH/PUT /customer/organization/update
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
    @competition = @org.competitions.build()
  end


  # POST /customer/create_competition
  #
  # The Competition model will also create a top-level Grouping.
  def create_competition
    respond_to do |format|
      if @org.competitions.create!(competition_params)
	flash[:notice] = 'You have a New Competition'
	format.html { redirect_to(:action => "show" ) }
      else
	format.html {  redirect_to(:action => "new_competition") }
      end
    end
  end
  

  # GET /customer/edit_competition/:id
  #
  # Grab the requested Competition and present it to the
  # user for edting.
  def edit_competition
    if @org.competitions.exists?(params[:competition_id])
      @competition = @org.competitions.find(params[:competition_id])
    else
      flash[:alert] = "Looks like an attempt to update somebody else's Competition" +
                       " or one that dosen't exist (#" +
                       params[:competition_id]+")"
      redirect_to(:oops)  
    end
  end


  # PUT/PATCH /customer/update_competition
  #
  # This will update the Competition specified in the form.
  def update_competition
    if @org.competitions.exists?(competition_params[:id])
      @competition = @org.competitions.find(competition_params[:id]) 
      @competition.update!(competition_params)
      redirect_to(:action => "show" )
    else
      flash[:alert] = "Looks like an attempt to update somebody else's Competition" +
                       " or one that dosen't exist (#" +
                       competition_params[:id].inspect()+")"
      redirect_to(:oops)  
    end
  end


  # GET /customer/edit_competition/:id
  #
  # Grab the requested Competition and present it to the
  # user for edting.
  def get_competition_link_recipient
    if @org.competitions.exists?(params[:competition_id])
      @competition = @org.competitions.find(params[:competition_id])
    else
      flash[:alert] = "Looks like an attempt to send a link to somebody else's Competition" +
                       " or one that dosen't exist (#" +
                       params[:competition_id]+")"
      redirect_to(:oops)  
    end
  end


  # PATCH /customer/send_competition_link
  #
  # This will update the Competition specified in the form.
  def send_competition_link
    if @org.competitions.exists?(competition_params[:id])
      @competition = @org.competitions.find(competition_params[:id]) 
      redirect_to(:action => "show" )
    else
      flash[:alert] = "Looks like an attempt to update somebody else's Competition" +
                       " or one that dosen't exist (#" +
                       competition_params[:id].inspect()+")"
      redirect_to(:oops)  
    end
  end

  private


    # Never trust parameters from the scary internet, only allow the white list through.
    def customer_params
      params.require(:customer).permit(:userid, :name, :phone, :website)
    end


    # Never trust parameters from the scary internet, only allow the white list through.
    def competition_params
      params.require(:competition).permit(:id, :name, :sport, :variety, :poolgroupseason, :poolgroupseasonlabel, :playoffbracket, :playoffbracketlabel, :keepscores, :winpoints, :drawpoints, :losspoints, :forfeitpoints, :forfeitwinscore, :forfeitlossscore)
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
