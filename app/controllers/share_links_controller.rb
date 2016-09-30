# 
# 
# 
class ShareLinksController < ApplicationController
  #before_action :set_customer_from_session

    # Array of Navigation links to display dependent
    # on whether Customer is logged in or not.
  def nav_link_array()
    []
  end

  # GET /customer/edit_competition/:id
  #
  # Grab the requested Competition and present it to the
  # user for edting.
  def get_competition_link_recipient
    if Competition.find(params[:competition_id])
      @competition = Competition.find(params[:competition_id])
      flash[:notice] = 'Enter the email address of the person you want to send the link to.' +
                 'Then select the type of link to be sent.  '  + 
		 'Then press the SEND button.'
    else
      flash[:alert] = "Looks like an attempt to send a link to somebody else's Competition" +
                       " or one that dosen't exist (#" +
                       params[:competition_id]+")"
      redirect_to(:oops)  
    end
  end


  # PATCH /customer/send_competition_link
  #
  # This will update the Competition specified in the form.
  def send_competition_link
    if Competition.find(competition_params[:id])
      @competition = Competition.find(competition_params[:id])
      recipient = params[:email][:recipient]
      type = params[:recipient][:type]
      case type
        when "Manager"
	  url =  login_manager_session_url(@competition)
	  ShareLinksEmailer.share_manager_link(@competition, recipient, url).deliver
	when "Scorer"
	  url =  login_scorer_session_url(@competition)
	  ShareLinksEmailer.share_scorer_link(@competition, recipient, url).deliver
	when "Fan View"
	  url =  display_competition_url(@competition)
	  ShareLinksEmailer.share_fan_view_link(@competition, recipient, url).deliver
	else
	  url = welcome_index_url
	end
      flash[:alert] = params[:recipient][:type] + 
		" Link was sent to " +params[:email][:recipient].inspect()
      redirect_to(get_competition_link_recipient_path(@competition))
    else
      flash[:alert] = "Looks like an attempt to update somebody else's Competition" +
                       " or one that dosen't exist (#" 
                       competition_params[:id].inspect()+")"
      redirect_to(:oops)  
    end
  end

  private


    # Never trust parameters from the scary internet, only allow the white list through.
    def competition_params
      params.require(:competition).permit(:id)
    end

end
