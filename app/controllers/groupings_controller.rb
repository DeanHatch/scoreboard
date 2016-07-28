class GroupingsController < ManagersController  # formerly ApplicationController

  before_action :set_grouping, only: [:show, :edit, :update, :destroy]

  # GET /groupings
  # GET /groupings.json
  def index
    @groupings = @manager.groupings
  end

  # GET /groupings/1
  # GET /groupings/1.json
  def show
  end

  # GET /groupings/new
  def new
    @groupings = @manager.groupings()
      # ALL does not include the Grouping about to be created.
      # That is why groupings is assigned first.
    @grouping = Grouping.new
    @grouping.manager = @manager
    @grouping.grouping = @groupings.select{|g| g.grouping().nil?}.first() # assign default
  end

  # GET /groupings/1/edit
  def edit
	  # list of groupings for drop-down
    @groupings = @manager.groupings
    @grouping_id = @grouping.id
  end

  # POST /groupings
  def create
    @grouping = Grouping.new(grouping_params)
    @grouping.manager = @manager
    
    respond_to do |format|
      if @grouping.save
	      flash[:notice] = 'Grouping was successfully created.'
        format.html { redirect_to groupings_url}
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /groupings/1
  # PATCH/PUT /groupings/1.json
  def update
    respond_to do |format|
	      flash[:notice] = 'Grouping was successfully updated.'
      if @grouping.update(grouping_params)
        format.html { redirect_to groupings_url}
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /groupings/1
  # DELETE /groupings/1.json
  def destroy
    @grouping.destroy
    respond_to do |format|
	      flash[:notice] = 'Team was successfully removed.'
	      format.html { redirect_to groupings_url}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_grouping
      @grouping = Grouping.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def grouping_params
      params.require(:grouping).permit(:competition_id, :name, :parent_id, :bracket_grouping)
    end
end
