# This controller displays the available Bracketgroupings and
# allows the user to select one for updating the Bracketcontests contained within.
# Bracketgroupings themselves are not created nor destroyed nor updated by this
# controller, it merely serves as a routing device. Therefore, it ha only two actions: #index and #show.
class BracketgroupingsController < ManagersController
  before_action :set_bracketgrouping, only: [:show, :complete, :complete_create]

  # GET /bracketgroupings
  def index
    @bracketgroupings = @manager.bracketgroupings
  end

  # GET /bracketgroupings/1
  def show
    @bracketcontests = @bracketgrouping.bracketcontests
  end


  # GET /bracketgroupings/1
  def complete
    logger.info("*** complete params: #{params.inspect()}")
    @numseeds = (params[:numseeds] ||= @bracketgrouping.all_teams.size()).to_i
    @numrounds = Math.log2(@numseeds).ceil
    logger.info("*** numseeds: #{@numseeds}")
    logger.info("*** numrounds: #{@numrounds}")
    logger.info("*** se_matchups: #{ @bracketgrouping.se_matchups(@numseeds).inspect()}")
    respond_to do |format|
      format.html { }
    end
  end


  # POST /bracketgroupings/1/complete_create
  def complete_create
    @bracketgrouping.complete_se_matchups(params[:numseeds].to_i)
    redirect_to bracketgrouping_path(@bracketgrouping)
  end


  # POST /bracketgroupings/1/complete_create
  def complete_delete
    @bracketgrouping.complete_se_matchups(params[:numseeds].to_i)
    redirect_to bracketgrouping_path(@bracketgrouping)
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bracketgrouping
      @bracketgrouping = Bracketgrouping.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bracketgrouping_params
      params[:bracketgrouping]
    end
end
