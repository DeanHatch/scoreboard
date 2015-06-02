class WelcomeController < ApplicationController

  def nav_link_array()
	  [ navitem('View a Competition' , :choose_display_customer) ,
  	     navitem('Report/Correct Scores' , :scorer_choose_customer) ,
	navitem('Manage a Competition' , :choose_customer_manager),
	navitem('Customer Login/Register', :new_customer_session) ]
  end

  def index
  end
  
  def send_us_a_message()
    SupportEmailer.rant(params).deliver_now
    redirect_to :thanks_for_the_message
  end
  
end
