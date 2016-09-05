class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception



  # Default link array. Should be overridden by controllers for this application.
  def nav_link_array()
	  [] # display_link_array()
  end

  def navitem(href, text, options={})
	  NavItem.new(href, text, options)
  end
   
  
  # Link array for the public display portion of this application.
  # The Display Controller should override this and provide its own navigation link array.
  def display_link_array()
	  [navitem('Public Display', :choose_display_organization)] 
  end

  # Link array for scorers, who can also open up the
  # public display portion of this application in a separate tab.
  def scorer_link_array()
	  [ navitem('Logout' , :logout_scorer_session )  ,
	navitem('View This Competition' , display_competition_path(@scorer.id), target: "_blank" ) ]
  end
  
  # Link array for Managers, who have access to everything related to the
  # application for a Competition.
  def manager_link_array()
	  [ navitem('Manage Dates/Venues' , :venues),
	navitem('Manage Game Times' , :valid_times),
	navitem('Manage Groupings/Teams' , :groupings),
	navitem('Schedule Regular Contests' , :regularcontests),
	navitem('Schedule Bracket Contests' , :bracketgroupings),
	navitem('Set Manager/Scorer Passwords' , :passwords_manager),
	navitem('Logout' , :logout_manager_session) ,
	navitem('Report/Correct Scores for This Competition' , login_scorer_session_path(@manager), target: "_blank" ),
	navitem('View This Competition' , display_competition_path(@manager), target: "_blank")  ]
  end

end
