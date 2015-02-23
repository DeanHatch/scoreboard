class WelcomeController < ApplicationController

  def nav_link_hash()
	  { 'Login/Register' => :customer  }
	  { 'Login/Register' => '/customer/login'  }
  end

  def nav_link_opts()
	  same_tab_opts()
  end

def index
  end
end
