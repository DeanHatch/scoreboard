require 'navitem.rb'

# The methods in this Module are used by most or all views in the application.
# Navigation is handled in a uniform manner, although the types of destinations
# are very different for the Manager functions than they are for the public viewers.
module ApplicationHelper

   # Following provides things like carrier pulldown.
  include SMSEasyHelper

  # Produce an Unordered List of Links for Navigation.
  # This may be called recursively.
  #  * ul_opts = HTML options for UL tag
  #  * li_opts = HTML options for LI tags
  #  * link_array = Array of navitems and/or Arrays
  # Note that if the Array element value is an Array, then this method will recurse for
  # an indented list.
  def nav_Panel(nav_level,
			link_array )
	  navitems = ''
	  # We have three sets of options: list options, list-item options, and link options.
	  ul_opts = {class: "nav1"}
	  li_opts = {class: "nav level#{nav_level}"}
		       # node is a NavItem
	  link_array.each { |node| node.class.name == "Array" ? 
						navitems << nav_Panel(nav_level + 1, node) :
						begin
						link_opts = {class: node.css_class, target: node.target}
						navitems << content_tag(:li,
										  link_to( node.href, node.text, link_opts),
										  li_opts)
						end
						}
	  raw(content_tag(:ul, raw(navitems), ul_opts))
  end


  # Start the process to produce a (nested) Unordered List of Links for Navigation.
  def navPanel()
	  nav_Panel(1, controller.nav_link_array)
  end
   
  def instructions()
  end
  
      # Accepts a list of objects.  Each object in the list must respond to
      # both #name and #id.  From this list of objects, an HTML Select/Options
      # element will be created. Optionally, an object from the list can be
      # pre-selected.
    def select_from_objects(objectList, chosen=nil)
    options_for_select(objectList.collect {|o| [ o.name, o.id ] },
				chosen ? {selected: chosen.id} : nil)
  end

  
end
