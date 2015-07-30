class BracketcontestsController < BracketgroupingsController

  before_action :set_bracketcontest, only: [:show, :edit, :update, :destroy]
  before_action :set_bracketgrouping # before ALL actions

  def set_bracketgrouping
	@bracketgrouping_id = params[:bracketgrouping_id]
	return(redirect_to(bracketgroupings_url)) unless @bracketgrouping_id
	begin
	@bracketgrouping = Bracketgrouping.find(@bracketgrouping_id)
	Bracketcontest.default_bracketgrouping(@bracketgrouping_id)
	rescue
	return redirect_to(bracketgroupings_url)
	end
    end

  def nav_link_hash()
	  manager_link_hash()
  end


  # GET /bracketcontests/1
  # GET /bracketcontests/1.json
  def show
  end

  # GET /bracketcontests/new
  def new
    @bracketcontest = Bracketcontest.new
      # This next statement is due to Manager inheriting from Competition.
    @bracketcontest.competition = @manager
    @bracketcontest.bracketgrouping_id = @bracketgrouping_id
    @selectedvenue = nil
    @selecteddate = nil
    @selectedtime = nil
    @selectedstatus = Bracketcontest.statuses.first
    @homecontestant = @bracketcontest.homecontestant
    @awaycontestant = @bracketcontest.awaycontestant
    @bracketcontest.name = "Game #{Bracketcontest.count()+1}"
  end

  # GET /bracketcontests/1/edit
  def edit
    @selectedvenue = @bracketcontest.venue_id
    @selecteddate = @bracketcontest.date
    @selectedtime = @bracketcontest.time
    @selectedstatus = @bracketcontest.status
    @homecontestant = @bracketcontest.homecontestant
    @awaycontestant = @bracketcontest.awaycontestant
  end

  # POST /bracketcontests
  # POST /bracketcontests.json
  def create
    @bracketcontest = Bracketcontest.new(bracketcontest_params)
      # This next statement is due to Manager inheriting from Competition.
    @bracketcontest.competition = @manager
    @bracketcontest.bracketgrouping_id = @bracketgrouping_id

    respond_to do |format|
      if @bracketcontest.save
	      save_contestants()
	      flash[:notice] = 'Bracketcontest was successfully created.' 
	      format.html { redirect_to  edit_bracketgrouping_bracketcontest_path(@bracketgrouping, @bracketcontest)}
	      format.json { render :show, status: :created, location: @bracketcontest }
	else
        format.html { render :new }
        format.json { render json: @bracketcontest.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bracketcontests/1
  # PATCH/PUT /bracketcontests/1.json
  def update
    respond_to do |format|
      if @bracketcontest.update(bracketcontest_params)
	save_contestants()
	flash[:notice] = 'Bracketcontest was successfully updated.' 
        format.html { redirect_to  [@bracketgrouping, @bracketcontest]}
        format.json { render :show, status: :ok, location: @bracketcontest }
      else
        format.html { render :edit }
        format.json { render json: @bracketcontest.errors, status: :unprocessable_entity }
      end
    end
  end


    # Use callbacks to share common setup or constraints between actions.
  private

    def set_bracketcontest
      @bracketcontest = Bracketcontest.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bracketcontest_params
      #params[:bracketcontest]
      params.require(:bracketcontest).
		permit(:date, :time, :venue_id, :status, :name)
    end
    def homecontestant_params
      params.require(:homecontestant).
		permit(:contestantcode, :seeding, :team_id)
    end
    def awaycontestant_params
      params.require(:awaycontestant).
		permit(:contestantcode, :seeding, :team_id)
    end
	
    def save_contestants	
	@bracketcontest.homecontestant.update!(homecontestant_params)
	@home_team_id = params.require(:homecontestant)[:team_id]
        @bracketcontest.homecontestant.team_id = @home_team_id if @home_team_id	
	@home_ctype = params.require(:homecontestant)[:contestanttype]
        @bracketcontest.homecontestant.contestanttype = @home_ctype if @home_ctype
        @bracketcontest.homecontestant.save! if @bracketcontest.homecontestant
	#return
	@bracketcontest.awaycontestant.update!(awaycontestant_params)
        @away_team_id = params.require(:awaycontestant)[:team_id]
        @bracketcontest.awaycontestant.team_id = @away_team_id if @away_team_id
        @bracketcontest.awaycontestant.save! if @bracketcontest.awaycontestant
    end

end
