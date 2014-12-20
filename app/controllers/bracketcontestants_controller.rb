class BracketcontestantsController < ApplicationController
  before_action :set_bracketcontestant, only: [:show, :edit, :update, :destroy]

  # GET /bracketcontestants
  # GET /bracketcontestants.json
  def index
    @bracketcontestants = Bracketcontestant.all
  end

  # GET /bracketcontestants/1
  # GET /bracketcontestants/1.json
  def show
  end

  # GET /bracketcontestants/new
  def new
    @bracketcontestant = Bracketcontestant.new
  end

  # GET /bracketcontestants/1/edit
  def edit
  end

  # POST /bracketcontestants
  # POST /bracketcontestants.json
  def create
    @bracketcontestant = Bracketcontestant.new(bracketcontestant_params)

    respond_to do |format|
      if @bracketcontestant.save
        format.html { redirect_to @bracketcontestant, notice: 'Bracketcontestant was successfully created.' }
        format.json { render :show, status: :created, location: @bracketcontestant }
      else
        format.html { render :new }
        format.json { render json: @bracketcontestant.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bracketcontestants/1
  # PATCH/PUT /bracketcontestants/1.json
  def update
    respond_to do |format|
      if @bracketcontestant.update(bracketcontestant_params)
        format.html { redirect_to @bracketcontestant, notice: 'Bracketcontestant was successfully updated.' }
        format.json { render :show, status: :ok, location: @bracketcontestant }
      else
        format.html { render :edit }
        format.json { render json: @bracketcontestant.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bracketcontestants/1
  # DELETE /bracketcontestants/1.json
  def destroy
    @bracketcontestant.destroy
    respond_to do |format|
      format.html { redirect_to bracketcontestants_url, notice: 'Bracketcontestant was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bracketcontestant
      @bracketcontestant = Bracketcontestant.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bracketcontestant_params
      params.require(:bracketcontestant).permit(:contest_id, :contest_type, :homeaway, :team_id, :score, :forfeit, :contestanttype, :seeding)
    end
end
