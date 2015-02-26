class GroupingsController < AdminController  # formerly ApplicationController

  before_action :set_grouping, only: [:show, :edit, :update, :destroy]

  # GET /groupings
  # GET /groupings.json
  def index
	#(1..14).each{|ci| Grouping.where(competition_id: ci).each{|g| g.destroy}; Competition.where(id: ci).each{|c| c.destroy}}
    @groupings = Grouping.where(competition_id: @competition_id)
  end

  # GET /groupings/1
  # GET /groupings/1.json
  def show
  end

  # GET /groupings/new
  def new
    @groupings = Grouping.where(competition_id: @competition_id)
      # ALL does not include the Grouping about to be created.
      # That is why groupings is assigned first.
    @grouping = Grouping.new
    @grouping.competition_id = @competition_id
  end

  # GET /groupings/1/edit
  def edit
	  # list of groupings for drop-down
    @groupings = Grouping.where(competition_id: @competition_id)
    @grouping_id = @grouping.id
  end

  # POST /groupings
  # POST /groupings.json
  def create
    @grouping = Grouping.new(grouping_params)
    @grouping.competition_id = @competition_id

    respond_to do |format|
      if @grouping.save
        format.html { redirect_to competition_groupings_url, notice: 'Grouping was successfully created.' }
        format.json { render :show, status: :created, location: @grouping }
      else
        format.html { render :new }
        format.json { render json: @grouping.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /groupings/1
  # PATCH/PUT /groupings/1.json
  def update
    respond_to do |format|
      if @grouping.update(grouping_params)
        format.html { redirect_to competition_groupings_url, notice: 'Grouping was successfully updated.' }
        format.json { render :show, status: :ok, location: @grouping }
      else
        format.html { render :edit }
        format.json { render json: @grouping.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /groupings/1
  # DELETE /groupings/1.json
  def destroy
    @grouping.destroy
    respond_to do |format|
      format.html { redirect_to competition_grouping_url, notice: 'Grouping was successfully destroyed.' }
      format.json { head :no_content }
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
