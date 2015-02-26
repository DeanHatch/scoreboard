class WelcomeController < ApplicationController

  def nav_link_array()
	  [ navitem('Public Display' , :competitions_display) ,
  	     navitem('Login/Register', '/customer/login') ]
  end

def index
  end
end
