# A Competition is created from the Organizationscontroller.
class CompetitionsController < ApplicationController
  before_action :set_competition, only: [:show, :edit, :update, :destroy]

  # GET /competitions
  # GET /competitions.json
  def index
    set_Organization()
    @competitions = Competition.all
  end

  # GET /competitions/1
  # GET /competitions/1.json
  def show
  end

  # GET /competitions/new
  def new
    @competition = Competition.new
  end

  # GET /competitions/1/edit
  def edit
  end

  # POST /competitions
  # POST /competitions.json
  def create
    @competition = Competition.new(competition_params)

    respond_to do |format|
      if @competition.save
	      # Also create a root Grouping object and save it.
	      # Note that, being the root Grouping, it will not have a parent Grouping.
	      # Note that this is done by the model in the #save method.
	      # Remember that the create competition action is initiated from the Organizations controller.
	      # After successful creation of a Competition, return to the
	      # greet action of the Organizations controller.
	flash[notice] = "Competition was successfully created."
	format.html { redirect_to greet_Organization_url }
        format.json { render :show, status: :created, location: @competition }
      else
        format.html { render :new }
        format.json { render json: @competition.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /competitions/1
  # PATCH/PUT /competitions/1.json
  def update
    respond_to do |format|
      if @competition.update(competition_params)
        format.html { redirect_to @competition, notice: 'Competition was successfully updated.' }
        format.json { render :show, status: :ok, location: @competition }
      else
        format.html { render :edit }
        format.json { render json: @competition.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /competitions/1
  # DELETE /competitions/1.json
  def destroy
    @competition.destroy
    respond_to do |format|
      format.html { redirect_to competitions_url, notice: 'Competition was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_Organization
      @Organization = Organization.find(params[:Organization_id])
      rescue
      begin
      @Organization = Organization.new()
      end
      Competition.default_cust(@Organization.id)
      Competition.default_cust(2)
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_competition
      @competition = Competition.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def competition_params
      params.require(:competition).permit(:name, :sport, :variety, :poolgroupseason, :poolgroupseasonlabel, :playoffbracket, :playoffbracketlabel, :keepscores, :winpoints, :drawpoints, :losspoints, :forfeitpoints, :forfeitwinscore, :forfeitlossscore)
    end
end
