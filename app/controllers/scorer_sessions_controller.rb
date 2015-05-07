class ScorerSessionsController < ApplicationController
  def new
    @scorer_id = params[:scorer_id]
    if Scorer.needs_no_authentication(@scorer_id)
      session[:scorer_id] = @scorer_id
      flash[:notice] = 'Welcome.'
      #redirect_to greet_scorer_path
      redirect_to competition_scorers_path(@scorer_id)
    else
      @scorer = Scorer.find(@scorer_id)
    end
  end


  def create
	  # scorer_id is sent as hidden value on form
	  @scorer = Scorer.authenticate(login_params[:scorer_id],
								login_params[:scorer_password])
	  if @scorer
		  session[:scorer_id] = @scorer.id
		  flash[:notice] = 'Welcome.'
		  redirect_to :scorer_index
	  else
		  @scorer = Scorer.new
		  @scorer.errors.add(:password, "is incorrect. Please try again.")
		  flash[:notice] = "Oops... Password is incorrect. Please try again."
		  redirect_to  login_scorer_session_path(login_params[:scorer_id]) 
	  end
  end

  def logout
	  session[:scorer_id] = nil
	  flash[:notice] = 'Bye.'
	  #redirect_to :login_scorer_session
	  redirect_to :root
  end

  private


    # Never trust parameters from the scary internet, only allow the white list through.
    def login_params
      params.require(:scorer_session).permit(:scorer_id, :scorer_password)
    end

end
