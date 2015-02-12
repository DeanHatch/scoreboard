class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  
  # Link options hash that opens actions in new tab.
  def new_tab_opts
	  {class: "nav", target: "_blank"}
  end
  # Link options hash that opens actions in same tab.
  def same_tab_opts
	  {class: "nav"}
  end

  # Default link options hash. Overridde by controllers for this application only if needed.
  def nav_link_opts()
	  new_tab_opts()
  end



  # Default link hash. Should be overridden by controllers for this application.
  def nav_link_hash()
	  {} # display_link_hash()
  end
	  
  
  # Link hash for the public display portion of this application.
  # The Display Controller should override this and provide its own navigation link hash.
  def display_link_hash()
	  { 'Public Display' => :display  }
  end

  # Link hash for scorers, who can also open up the
  # public display portion of this application in a separate tab.
  def scorer_link_hash()
	  { 'Record/Revise Scores' => :scorer ,
	'Public Display' => :display  }
  end

  # Link hash for schedulers, who can also open up the scorer and the
  # public display portions of this application in a separate tab.
  def scheduler_link_hash()
	  { 'Schedule Regular Contests' => :competition_regularcontests,
	'Schedule Bracket Contests' => :bracketcontests ,
	'Record/Revise Scores' => :scorer ,
	'Public Display' => :display  }
  end
  
  # Link hash for admins, who have access to everything related to the
  # application for a Competition.
  def admin_link_hash()
	  { 'Manage Dates/Venues' => :competition_venues,
	'Manage Groupings/Teams' => :competition_groupings,
	'Schedule Regular Contests' => :competition_regularcontests,
	'Schedule Bracket Contests' => :bracketcontests ,
	'Record/Revise Scores' => :scorer ,
	'Public Display' => :display  }
	
	  { 'Manage Dates/Venues' => :competition_venues,
	'Manage Groupings/Teams' => :competition_groupings,
	'Schedule Regular Contests' => :competition_regularcontests,
	'Schedule Bracket Contests' => :competition_brackets  }
  end


end
