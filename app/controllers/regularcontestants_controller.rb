class RegularcontestantsController < ApplicationController
  before_action :set_regularcontestant, only: [:show, :edit, :update, :destroy]

  # GET /regularcontestants
  # GET /regularcontestants.json
  def index
    @regularcontestants = Regularcontestant.all
  end

  # GET /regularcontestants/1
  # GET /regularcontestants/1.json
  def show
  end

  # GET /regularcontestants/new
  def new
    @regularcontestant = Regularcontestant.new(:contest_type => 'regularcontest',
                                                                   :forfeit => false,
								    homeaway: 'H')
    @selectedteam = nil
  end

  # GET /regularcontestants/1/edit
  def edit
    @selectedteam = @regularcontestant.team_id
  end

  # POST /regularcontestants
  # POST /regularcontestants.json
  def create
    @regularcontestant = Regularcontestant.new(regularcontestant_params)

    respond_to do |format|
      if @regularcontestant.save
        format.html { redirect_to @regularcontestant, notice: 'Regularcontestant was successfully created.' }
        format.json { render :show, status: :created, location: @regularcontestant }
      else
        format.html { render :new }
        format.json { render json: @regularcontestant.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /regularcontestants/1
  # PATCH/PUT /regularcontestants/1.json
  def update
    respond_to do |format|
      if @regularcontestant.update(regularcontestant_params)
        format.html { redirect_to @regularcontestant, notice: 'Regularcontestant was successfully updated.' }
        format.json { render :show, status: :ok, location: @regularcontestant }
      else
        format.html { render :edit }
        format.json { render json: @regularcontestant.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /regularcontestants/1
  # DELETE /regularcontestants/1.json
  def destroy
    @regularcontestant.destroy
    respond_to do |format|
      format.html { redirect_to regularcontestants_url, notice: 'Regularcontestant was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_regularcontestant
      @regularcontestant = Regularcontestant.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def regularcontestant_params
      params.require(:regularcontestant).permit(:contest_id, :contest_type, :homeaway, :team_id, :score, :forfeit)
    end
end
