class TeamsController < ManagersController
  before_action :set_team, only: [:show, :edit, :update, :destroy]
  before_action :set_grouping

  # GET /teams
  # GET /teams.json
  def index
    @teams = Team.where(competition_id: @competition_id, grouping_id: @grouping.id)
  end

  # GET /teams/1
  # GET /teams/1.json
  def show
  end

  # GET /teams/new
  def new
    @team = Team.new
    @team.competition_id = @competition_id
    @team.grouping_id = @grouping_id
    @groupings = Grouping.where(competition_id: @competition_id)
  end

  # GET /teams/1/edit
  def edit
    @groupings = Grouping.where(competition_id: @competition_id)
  end

  # POST /teams
  # POST /teams.json
  def create
    @team = Team.new(team_params)
    @team.competition_id = @competition.id
    @team.grouping_id = @grouping.id

    respond_to do |format|
      if @team.save
	      flash[:notice] = 'Team was successfully created.'
	      format.html { redirect_to grouping_teams_path }
	      format.json { render :show, status: :created, location: @team }
      else
        format.html { render :new }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /teams/1
  # PATCH/PUT /teams/1.json
  def update
    respond_to do |format|
      if @team.update(team_params)
	      flash[:notice] = 'Team was successfully updated.'
	      format.html { redirect_to @team }
	      format.json { render :show, status: :ok, location: @team }
      else
        format.html { render :edit }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /teams/1
  # DELETE /teams/1.json
  def destroy
    @team.destroy
    respond_to do |format|
	      flash[:notice] = 'Team was successfully deleted.'
	      format.html { redirect_to teams_url}
	      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_grouping
      @grouping = Grouping.find(params[:grouping_id])
    end

    def set_team
      @team = Team.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def team_params
      params.require(:team).permit(:competition_id, :name, :grouping_id)
    end
end
