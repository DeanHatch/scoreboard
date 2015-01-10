class RegularcontestsController < ApplicationController
  before_action :set_regularcontest, only: [:show, :edit, :update, :destroy]

  # GET /regularcontests
  # GET /regularcontests.json
  def index
    @regularcontests = Regularcontest.all
  end

  # GET /regularcontests/1
  # GET /regularcontests/1.json
  def show
  end

  # GET /regularcontests/new
  def new
    @regularcontest = Regularcontest.new
    @selectedvenue = nil
    @selecteddate = nil
    @selectedtime = nil
    @selectedstatus = Regularcontest.statuses.first
    
    @homecontestant = Regularcontestant.new
    @homecontestant.homeaway = 'H'
    
    @awaycontestant = Regularcontestant.new
    @awaycontestant.homeaway = 'A'
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

    respond_to do |format|
      if @regularcontest.save
        format.html { redirect_to @regularcontest, notice: 'Contest scheduled.' }
        format.json { render :show, status: :created, location: @regularcontest }
      else
        format.html { render :new }
        format.json { render json: @regularcontest.errors, status: :unprocessable_entity }
      end # of if-then-else
    end # of do
    
    @regularcontest.awaycontestant = Regularcontestant.new(:contest_type => 'Regularcontest',
                                                                   :forfeit => false,
								    homeaway: 'A',
								    contest_id: @regularcontest.id)
    
    @regularcontest.homecontestant = Regularcontestant.new(:contest_type => 'Regularcontest',
                                                                  :forfeit => false,
								    homeaway: 'H',
								    contest_id: @regularcontest.id)
    
  end # of def create

  # PATCH/PUT /regularcontests/1
  # PATCH/PUT /regularcontests/1.json
  def update
    respond_to do |format|
      if @regularcontest.update(regularcontest_params)
        format.html { redirect_to @regularcontest, notice: 'Contest was successfully updated.' }
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
        format.html { redirect_to @regularcontest, notice: 'Contest was successfully updated.' }
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
  end

  # POST/regularcontests/roundrobin
  # POST /regularcontests/roundrobin.json
  def roundrobin
	  @grouping = Grouping.find(params[:grouping_id])
	  arr = @grouping.teams().to_a
	  # Add BYE (nil Team) if necessary, to create an Array 
	  # with an even number of elements. 
	  #arr << nil if arr.size.modulo(2)==1 
	  arr << nil if arr.size.odd?
	  @contests = Array.new() 
	  #return contests 
	  0.upto(arr.size-2) { |idx| 0.upto((arr.size/2)-1) { |jth| 
						#jth = -1 * jth if (idx.modulo(2)==0) 
						if ! arr[jth].nil? and ! arr[-1-jth].nil? 
							#xyz = Regularcontest.new() 
							#xyz.homecontestant.team = arr[jth] 
							#xyz.awaycontestant.team = arr[-1-jth] 
							@regularcontest = Regularcontest.new(roundrobin_params)
							@regularcontest.status = 'SCHED'
							@regularcontest.awaycontestant = Regularcontestant.new(:contest_type => 'Regularcontest',
                                                                   :forfeit => false,
								    homeaway: 'A',
								    contest_id: @regularcontest.id)
							@regularcontest.awaycontestant.team = arr[-1-jth]
							@regularcontest.homecontestant = Regularcontestant.new(:contest_type => 'Regularcontest',
                                                                  :forfeit => false,
								    homeaway: 'H',
								    contest_id: @regularcontest.id)
							@regularcontest.homecontestant.team = arr[jth]
							#@contests << xyz 
							@contests << @regularcontest if @regularcontest.save
						end # of if-then 
						} 
					# Rotate all elements but the first. 
					#arr.push(arr.slice!(1)) 
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
      params.require(:regularcontest).permit(:date, :time, :venue_id, :status)
    end
end
