class WelcomeController < ApplicationController

  def nav_link_array()
	  [ navitem('Public Display' , :choose_display_customer) ,
  	     #navitem('Report/Correct Scores' , :schmenge) ,
	#navitem('Manage a Competition' , :competition_venues),,
	#navitem('Manage a Competition' , :competitions_display),
	navitem('Login/Register', '/customer/login') ]
  end

def index
  end
end
