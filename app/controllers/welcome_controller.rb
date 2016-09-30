class WelcomeController < ApplicationController

  def nav_link_array()
    [navitem('Customer Log In' , new_customer_session_path())]
  end

  def index
    organizations = Organization.unscoped.all()
    # logger.info("session info is: #{session.inspect()}")
  end
  
  def send_us_a_message()
    SupportEmailer.rant(params).deliver
    redirect_to :thanks_for_the_message
  end
  
end
