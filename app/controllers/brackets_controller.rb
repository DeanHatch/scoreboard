# This controller displays the available Bracket Groupings and
# allows the user to select one for updating the Bracketcontests contained within.
# Brackets themselves are not created nor destroyed nor updated by this
# controller, it merely serves as a routing device. Therefore, it ha only two actions: #index and #show.
class BracketsController < NestedController
  before_action :set_bracket, only: :show

  def nav_link_hash()
	  admin_link_hash()
  end

  # GET /brackets
  # GET /brackets.json
  def index
    @brackets = Bracket.all
  end

  # GET /brackets/1
  # GET /brackets/1.json
  def show
	  @bracketcontests = Bracketcontest.where(bracket_id: @bracket.id)
	  #@bracket_id = @bracket.id
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bracket
      @bracket = Bracket.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bracket_params
      params[:bracket]
    end
end
