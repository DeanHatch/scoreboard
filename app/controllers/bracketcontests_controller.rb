class BracketcontestsController < ApplicationController
  before_action :set_bracketcontest, only: [:show, :edit, :update, :destroy]

  # GET /bracketcontests
  # GET /bracketcontests.json
  def index
    @bracketcontests = Bracketcontest.all
  end

  # GET /bracketcontests/1
  # GET /bracketcontests/1.json
  def show
  end

  # GET /bracketcontests/new
  def new
    @bracketcontest = Bracketcontest.new
    @selectedvenue = nil
    @selectedstatus = Bracketcontest.statuses.first
  end

  # GET /bracketcontests/1/edit
  def edit
    @selectedvenue = @bracketcontest.venue_id
    @selectedstatus = @bracketcontest.status
  end

  # POST /bracketcontests
  # POST /bracketcontests.json
  def create
    @bracketcontest = Bracketcontest.new(bracketcontest_params)

    respond_to do |format|
      if @bracketcontest.save
        format.html { redirect_to @bracketcontest, notice: 'Bracketcontest was successfully created.' }
        format.json { render :show, status: :created, location: @bracketcontest }
      else
        format.html { render :new }
        format.json { render json: @bracketcontest.errors, status: :unprocessable_entity }
      end # of if-then-else
    end # of do
    
    @bracketcontest.awaycontestant = Bracketcontestant.new(:contest_type => 'Bracketcontest',
                                                                   :forfeit => false,
								    homeaway: 'A',
								    contest_id: @bracketcontest.id)
    
    @bracketcontest.homecontestant = Bracketcontestant.new(:contest_type => 'Bracketcontest',
                                                                  :forfeit => false,
								    homeaway: 'H',
								    contest_id: @bracketcontest.id)
    
  end # of def create

  # PATCH/PUT /bracketcontests/1
  # PATCH/PUT /bracketcontests/1.json
  def update
    respond_to do |format|
      if @bracketcontest.update(bracketcontest_params)
        format.html { redirect_to @bracketcontest, notice: 'Bracketcontest was successfully updated.' }
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
      format.html { redirect_to bracketcontests_url, notice: 'Bracketcontest was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bracketcontest
      @bracketcontest = Bracketcontest.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bracketcontest_params
      params.require(:bracketcontest).permit(:date, :time, :venue_id, :status)
    end
end
