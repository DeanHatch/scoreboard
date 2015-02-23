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
	  [navitem('Public Display', :display)] 
  end

  # Link array for scorers, who can also open up the
  # public display portion of this application in a separate tab.
  def scorer_link_array()
	  [ navitem('Record/Revise Scores' , :scorer) ,
	navitem('Public Display' , :display ) ]
  end

  # Link array for schedulers, who can also open up the scorer and the
  # public display portions of this application in a separate tab.
  def scheduler_link_array()
	  [ navitem('Schedule Regular Contests' , :competition_regularcontests),
	navitem('Schedule Bracket Contests' , :bracketcontests ),
	navitem('Record/Revise Scores' , :scorer ),
	navitem('Public Display' , :display)  ]
  end
  
  # Link array for admins, who have access to everything related to the
  # application for a Competition.
  def admin_link_array()
	  [ navitem('Manage Dates/Venues' , :competition_venues),
	navitem('Manage Groupings/Teams' , :competition_groupings),
	navitem('Schedule Regular Contests' , :competition_regularcontests),
	navitem('Schedule Bracket Contests' , :bracketcontests) ,
	navitem('Record/Revise Scores' , :scorer) ,
	navitem('Public Display' , :display, target: "_blank")  ]
	
	  [ navitem('Manage Dates/Venues' , :competition_venues),
	navitem('Manage Groupings/Teams' , :competition_groupings),
	navitem('Schedule Regular Contests' , :competition_regularcontests),
	navitem('Schedule Bracket Contests' , :competition_brackets)  ]
  end


end
