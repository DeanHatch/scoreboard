class ValidTimesController  < ManagersController
  before_action :set_valid_time, only: [:show, :edit, :update, :destroy]

  # GET /valid_times
  # GET /valid_times.json
  def index
  end

  # GET /valid_times/1
  # GET /valid_times/1.json
  def show
  end

  # GET /valid_times/new
  def new
    @valid_time = ValidTime.new
  end

  # GET /valid_times/1/edit
  def edit
  end

  # POST /valid_times
  # POST /valid_times.json
  def create
    @valid_time = ValidTime.new(valid_time_params)
    @valid_time.manager = @manager

    respond_to do |format|
      if @valid_time.save!
        format.html { redirect_to :valid_times, notice: 'Valid time was successfully created.' }
        format.json { render :show, status: :created, location: @valid_time }
      else
        format.html { render :new }
        format.json { render json: @valid_time.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /valid_times/1
  # PATCH/PUT /valid_times/1.json
  def update
    respond_to do |format|
      if @valid_time.update(valid_time_params)
        format.html { redirect_to :valid_times, notice: 'Valid time was successfully created.' }
        format.json { render :show, status: :ok, location: @valid_time }
      else
        format.html { render :edit }
        format.json { render json: @valid_time.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /valid_times/1
  # DELETE /valid_times/1.json
  def destroy
    @valid_time.destroy
    respond_to do |format|
      format.html { redirect_to valid_times_url, notice: 'Valid time was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_valid_time
      @valid_time = ValidTime.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def valid_time_params
      params.require(:valid_time).permit(:competition_id, :grouping_id, :venue_id, :from_time, :to_time)
    end
end
