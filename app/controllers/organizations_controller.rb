# In the routes file, Organization is a Singular Resource. A Organization establishes a
# Session via a login page/action. Subsequent actions are performed on a
# single Organization, identified by the organization_id in the Session.
class OrganizationsController < ApplicationController
  before_action :set_organization_from_session, except: [:new, :create, :confirm, :reset_password]

  # Use this Link Array when Organization is both Confirmed and Logged In. 
  def fullnav()
      [navitem('Edit Profile' , :edit_organization),
	     navitem('Create a New Competition' , :new_competition_organization),
	     navitem('Manage My Competitions' , choose_competition_manager_path(@organization), target: "_blank") ] 
  end

  # Link Array. 
  def nav_link_array()
    []
  end
 

  # GET /organizations/1
  # GET /organizations/1.json
  def greet
    @competitions = @organization.competitions
  end

  # GET /organizations/new
  def new
    @organization = Organization.new
  end

  # GET /organization/edit
  def edit
  end

  # POST /organizations
  def create
    @organization = Organization.new(organization_params)

    respond_to do |format|
      if @organization.save
        #OrganizationMailer.welcome(@organization.userid).deliver_later
	#OrganizationEmailer.welcome(@organization).deliver
	format.html {  redirect_to greet_organization_path }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /organizations/1
  def update
    respond_to do |format|
      if @organization.update(organization_params)
	flash[:notice] = 'Changes made.'
        format.html { redirect_to greet_organization_path}
      else
        format.html { render :edit }
      end
    end
  end

  # GET /organization/new_competition
  def new_competition
	  @competition = Competition.new
  end


  # POST /organization/create_competition
  def create_competition
	  @competition = Competition.new(competition_params)
	  @competition.organization = @organization
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
    def new_organization_params
      params.require(:organization).permit(:userid)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def organization_params
      params.require(:organization).permit(:userid, :name, :phone, :website)
    end


    # Never trust parameters from the scary internet, only allow the white list through.
    def competition_params
      params.require(:competition).permit(:name, :sport, :variety, :poolgroupseason, :poolgroupseasonlabel, :playoffbracket, :playoffbracketlabel, :keepscores, :winpoints, :drawpoints, :losspoints, :forfeitpoints, :forfeitwinscore, :forfeitlossscore)
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_organization_from_session
      @organization = Organization.find(session[:organization_id])
      rescue
      begin
        logger.info("Organization #{session[:organization_id]} not found...")
      @organization = Organization.new()
      redirect_to oops_path
      end
    logger.info("Organization #{session[:organization_id]} WAS found...")
    end

end
