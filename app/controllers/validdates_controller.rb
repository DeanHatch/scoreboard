# The only action this controler performs is to CREATE a ValidDate for a Competition.
class ValiddatesController < ManagersController

  # POST /validdates
  # POST /validdates.json
  def create
    @validdate = Validdate.new(validdate_params)
    @validdate.manager = @manager

    respond_to do |format|
	      # Note that we return to Venues Controller
      if @validdate.save
	flash[:notice] = 'Validdate was successfully created.' 
        format.html { redirect_to venues_url}
        format.json { render :show, status: :created, location: @validdate }
      else
        format.html { render :new }
        format.json { render json: @validdate.errors, status: :unprocessable_entity }
      end
    end
  end

  private
 
    # Never trust parameters from the scary internet, only allow the white list through.
    def validdate_params
      params.require(:validdate).permit(:gamedate, :competition_id)
    end
end
