class VenuesController < ManagersController

  before_action :set_venue, only: [:show, :edit, :update, :destroy]

  # GET /venues
  # GET /venues.json
  def index
    @venues = Venue.where(competition_id: @competition_id)
      # Need a venue object for form which is now on index page
    @venue = Venue.new()
    @venue.competition_id = @competition_id
    @validdates = Validdate.where(competition_id: @competition_id)
      # Need a validdate object for form which is now on index page
    @validdate = Validdate.new  # index contains the validdateform
  end

  # GET /venues/1
  # GET /venues/1.json
  def show
  end

  # GET /venues/new
  def new
    @venue = Venue.new
  end

  # GET /venues/1/edit
  def edit
  end

  # POST /venues
  # POST /venues.json
  def create
    @venue = Venue.new(venue_params)
    @venue.competition_id = @competition_id

    respond_to do |format|
      if @venue.save
	      flash[:notice] = 'Venue was successfully created.' 
	      format.html { redirect_to venues_url}
	      format.json { render :show, status: :created, location: @venue }
      else
        format.html { render :new }
        format.json { render json: @venue.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /venues/1
  # PATCH/PUT /venues/1.json
  def update
    respond_to do |format|
      if @venue.update(venue_params)
	      flash[:notice] = 'Venue was successfully updated.' 
        format.html { redirect_to venues_url}
        format.json { render :show, status: :ok, location: @venue }
      else
        format.html { render :edit }
        format.json { render json: @venue.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /venues/1
  # DELETE /venues/1.json
  def destroy
    @venue.destroy
    respond_to do |format|
	      flash[:notice] = 'Venue was successfully removed.' 
	      format.html { redirect_to venues_url }
	      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_venue
      @venue = Venue.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def venue_params
      params.require(:venue).permit(:name, :competition_id)
    end
end
