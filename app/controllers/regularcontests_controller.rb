class RegularcontestsController < NestedController  # formerly  ApplicationController
  before_action :set_regularcontest, only: [:show, :edit, :update, :destroy]


  def nav_link_hash()
	  admin_link_hash()
  end


  # GET /regularcontests
  # GET /regularcontests.json
  def index
    @regularcontests = Regularcontest.all
    
  end
  
  # GET /regularcontests
  # GET /regularcontests.json
  def dump
	#  Grouping.where('id>0').each{|g| g.bracket_grouping=false;g.save }
	#  Team.where('id=26').each{|t| t.destroy }
	#  Bracketcontest.where(homecontestant_id: nil).each{|rc| rc.destroy }
	#  Bracketcontestant.all.each{|rc| rc.destroy }
	#  Bracketcontest.all.each{|rc| rc.destroy }
	#  Bracketcontestant.where('contest_id=82').each{|bc| bc.seeding=bc.team_id; bc.save }
	#  Bracketcontest.where('id=82').each{|bc| bc.competition_id=17; bc.bracket_grouping_id=13; bc.save }
	#  Regularcontest.where('id<92').each{|rc| rc.destroy }
    @regularcontests = Regularcontest.all
  end

  # GET /regularcontests/1
  # GET /regularcontests/1.json
  def show
  end

  # GET /regularcontests/new
  def new
    @regularcontest = Regularcontest.new
    @regularcontest.competition_id = @competition_id
    @selectedvenue = nil
    @selecteddate = nil
    @selectedtime = nil
    @selectedstatus = Regularcontest.statuses.first
    @homecontestant = @regularcontest.homecontestant
    @awaycontestant = @regularcontest.awaycontestant
  end

  # GET /regularcontests/1/edit
  def edit
    @selectedvenue = @regularcontest.venue_id
    @selecteddate = @regularcontest.date
    @selectedtime = @regularcontest.time
    @selectedstatus = @regularcontest.status
    @homecontestant = @regularcontest.homecontestant
    @awaycontestant = @regularcontest.awaycontestant
  end

  # POST /regularcontests
  # POST /regularcontests.json
  def create
    @regularcontest = Regularcontest.new(regularcontest_params)
    @regularcontest.competition_id = @competition_id

    respond_to do |format|
      if @regularcontest.save
        format.html { redirect_to [@competition, @regularcontest], notice: 'Regularcontest was successfully created.' }
       # format.html { redirect_to competition_regularcontests_url, notice: 'Regularcontest was successfully created.' }
        format.json { render :show, status: :created, location: @regularcontest }
      else
        format.html { render :new }
        format.json { render json: @regularcontest.errors, status: :unprocessable_entity }
      end
    end
  
   end # of def create

  # PATCH/PUT /regularcontests/1
  # PATCH/PUT /regularcontests/1.json
  def update
    @home_team_id = params.require(:regularcontest)[:home_team_id]
    @regularcontest.homecontestant.team_id = @home_team_id if @home_team_id
    @regularcontest.homecontestant.save if @regularcontest.homecontestant
    @away_team_id = params.require(:regularcontest)[:away_team_id]
    @regularcontest.awaycontestant.team_id = @away_team_id if @away_team_id
    @regularcontest.awaycontestant.save if @regularcontest.awaycontestant
    respond_to do |format|
      if @regularcontest.update(regularcontest_params)
        format.html { redirect_to [@competition, @regularcontest], notice: 'Contest was successfully updated.'}
        format.json { render :show, status: :ok, location: @regularcontest }
      else
        format.html { render :edit }
        format.json { render json: @regularcontest.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /regularcontests/cancel/1
  # PATCH/PUT /regularcontests/cancel/1.json
  def cancel
    @regularcontest.status = 'CAN'
    respond_to do |format|
      if @regularcontest.update(regularcontest_params)
        format.html { redirect_to @regularcontest, notice: 'Contest was cancelled.' }
        format.json { render :show, status: :ok, location: @regularcontest }
      else
        format.html { render :edit }
        format.json { render json: @regularcontest.errors, status: :unprocessable_entity }
      end
    end
  end

 
  # DELETE /regularcontests/1
  # DELETE /regularcontests/1.json
  def destroy
    @regularcontest.destroy
    respond_to do |format|
      format.html { redirect_to regularcontests_url, notice: 'Regularcontest was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  # GET/regularcontests/rrobin
  # GET /regularcontests/rrobin.json
  def rrobin
    @groupings = Grouping.all
    @venues = Venue.all
  end

  # POST/regularcontests/roundrobin
  # POST /regularcontests/roundrobin.json
  def roundrobin
	  @grouping = Grouping.find(params[:grouping_id])
	  arr = @grouping.teams().to_a
	  # Add BYE (nil Team) if necessary, to create an Array 
	  # with an even number of elements.
	  # We will not keep those Contests with a nil Team.
	  arr << nil if arr.size.odd?
	  @contests = Array.new() 
	  # The "j-th" team from the front of the array will be matched with the "j-th"
	  # team from the end of the array.
	  # We need to think about flipping Home/Away, possibly.
	  # Maybe "if jth.modulo(2)==1 "
	  0.upto(arr.size-2) { |idx| 0.upto((arr.size/2)-1) { |jth| 
						if ! arr[jth].nil? and ! arr[-1-jth].nil? 
							@regularcontest = Regularcontest.new(roundrobin_params)
							@regularcontest.competition_id = @competition_id
							@regularcontest.status = 'SCHED'
							@regularcontest.awaycontestant.team = arr[-1-jth]
							@regularcontest.homecontestant.team = arr[jth]
							@contests << @regularcontest if @regularcontest.save
						end # of if-then 
						} 
					# Rotate all elements but the first. 
					arr[1..arr.size]=arr[1..arr.size].rotate
					} 
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_regularcontest
      @regularcontest = Regularcontest.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def roundrobin_params
      params.permit(:date, :time, :venue_id, :status)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def regularcontest_params
      #params[:regularcontest]
      params.require(:regularcontest).
		permit(:date, :time, :venue_id, :status)

    end
end
