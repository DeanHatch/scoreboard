class TeamsController < ManagersController
  before_action :set_team, only: [:show, :edit, :update, :destroy]
  before_action :set_grouping, only: [:index, :new, :create]

  # Only show Teams for this Grouping
  # GET /grouping/1/teams
  def index
    @teams = Team.where(competition: @competition, grouping: @grouping)
  end

  # GET /teams/1
  def show
    @grouping = @team.grouping()
  end

  # GET /grouping/1/teams/new
  def new
    @team = Team.new
    @team.competition = @competition
    @team.grouping = @grouping
  end

  # POST /teams
  def create
    @team = Team.new(team_params)
    @team.competition = @competition
    @team.grouping = @grouping

    respond_to do |format|
      if @team.save
	      flash[:notice] = 'Team was successfully added.'
	      format.html { redirect_to grouping_teams_path }
      else
        format.html { render :new }
      end
    end
  end

  # GET /teams/1/edit
  def edit
	     # User can change the Grouping
    @groupings = Grouping.where(competition: @competition)
  end

  # PATCH/PUT /teams/1
  def update
      # get Grouping BEFORE Update in case it changes.
      # We need the old Grouping for the redirect.
    grouping_id = @team.grouping.id
    respond_to do |format|
      if @team.update(team_params)
	      flash[:notice] = 'Team was successfully updated.'
	      format.html { redirect_to( {action: :index , :grouping_id => grouping_id}) }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /teams/1
  def destroy
      # get Grouping BEFORE Destroy for the redirect.
    grouping_id = @team.grouping.id
    @team.destroy
    respond_to do |format|
	      flash[:notice] = 'Team was successfully removed.'
	      format.html { redirect_to ( {action: :index , :grouping_id => grouping_id})}
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
