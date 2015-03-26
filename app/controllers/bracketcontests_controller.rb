class BracketcontestsController < BracketsController

  before_action :set_bracketcontest, only: [:show, :edit, :update, :destroy]
  before_action :set_bracket # before ALL actions

  def set_bracket
	@bracket_id = params[:bracket_id]
	return(redirect_to(brackets_url)) unless @bracket_id
	begin
	@bracket = Bracket.find(@bracket_id)
	Bracketcontest.default_bracket(@bracket_id)
	rescue
	return redirect_to(brackets_url)
	end
    end

  def nav_link_hash()
	  manager_link_hash()
  end

  # GET /bracketcontests
  # GET /bracketcontests.json
  def index
    @bracketcontests = Bracketcontest.all
  end
  
  # GET /regularcontests
  # GET /regularcontests.json
  def dump
	#  Team.where('id=26').each{|t| t.destroy }
	#  Bracketcontest.where(homecontestant_id: nil).each{|rc| rc.destroy }
	#  Regularcontest.where('id<92').each{|rc| rc.destroy }
    @bracketcontests = Bracketcontest.all
  end

  # GET /bracketcontests/1
  # GET /bracketcontests/1.json
  def show
  end

  # GET /bracketcontests/new
  def new
    @bracketcontest = Bracketcontest.new
    @bracketcontest.competition_id = @competition_id
    @bracketcontest.bracket_id = @bracket_id
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
    @bracketcontest.competition_id = @competition_id
    @bracketcontest.bracket_id = @bracket_id

    respond_to do |format|
      if @bracketcontest.save
	      save_contestants()
	      flash[:notice] = 'Bracketcontest was successfully created.' 
	      format.html { redirect_to  edit_bracket_bracketcontest_path(@bracket, @bracketcontest)}
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
        format.html { redirect_to  [@bracket, @bracketcontest]}
        format.json { render :show, status: :ok, location: @bracketcontest }
      else
        format.html { render :edit }
        format.json { render json: @bracketcontest.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bracketcontests/1
  # DELETE /bracketcontests/1.json
  def destroy
    @bracketcontest.destroy
    respond_to do |format|
	flash[:notice] = 'Bracketcontest was successfully created.' 
      format.html { redirect_to bracketcontests_url }
      format.json { head :no_content }
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
