class ValiddatesController < ApplicationController
  before_action :set_validdate, only: [:show, :edit, :update, :destroy]

  # GET /validdates
  # GET /validdates.json
  def index
    @validdates = Validdate.all
  end

  # GET /validdates/1
  # GET /validdates/1.json
  def show
  end

  # GET /validdates/new
  def new
    @validdate = Validdate.new
  end

  # GET /validdates/1/edit
  def edit
  end

  # POST /validdates
  # POST /validdates.json
  def create
    @validdate = Validdate.new(validdate_params)

    respond_to do |format|
      if @validdate.save
        format.html { redirect_to @validdate, notice: 'Date was successfully added.' }
        format.json { render :show, status: :created, location: @validdate }
      else
        format.html { render :new }
        format.json { render json: @validdate.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /validdates/1
  # PATCH/PUT /validdates/1.json
  def update
    respond_to do |format|
      if @validdate.update(validdate_params)
        format.html { redirect_to @validdate, notice: 'Validdate was successfully updated.' }
        format.json { render :show, status: :ok, location: @validdate }
      else
        format.html { render :edit }
        format.json { render json: @validdate.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /validdates/1
  # DELETE /validdates/1.json
  def destroy
    @validdate.destroy
    respond_to do |format|
      format.html { redirect_to validdates_url, notice: 'Validdate was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_validdate
      @validdate = Validdate.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def validdate_params
      params.require(:validdate).permit(:gamedate)
    end
end
