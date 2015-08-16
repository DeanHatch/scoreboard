# This controller displays the available Bracketgroupings and
# allows the user to select one for updating the Bracketcontests contained within.
# Bracketgroupings themselves are not created nor destroyed nor updated by this
# controller, it merely serves as a routing device. Therefore, it ha only two actions: #index and #show.
class BracketgroupingsController < ManagersController
  before_action :set_bracketgrouping, only: [:show, :complete]

  # GET /bracketgroupings
  def index
    #@bracketgroupings = Bracketgrouping.all
    @bracketgroupings = @manager.bracketgroupings
  end

  # GET /bracketgroupings/1
  def show
	  @bracketcontests = Bracketcontest.where(bracketgrouping: @bracketgrouping)
  end


  # GET /bracketgroupings/1
  def complete
    @bracketgrouping.complete_se_matchups()
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
