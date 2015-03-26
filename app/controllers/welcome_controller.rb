class WelcomeController < ApplicationController

  def nav_link_array()
	  [ navitem('Public Display' , :choose_display_customer) ,
  	     navitem('Report/Correct Scores' , :choose_results_customer) ,
	navitem('Manage a Competition' , :choose_customer_manager),
	navitem('Customer Login/Register', :new_customer_session) ]
  end

def index
  end
end
