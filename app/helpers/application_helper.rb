require 'navitem.rb'

module ApplicationHelper

  def html_headings_for(arr)
	  headings = ''
	  arr.each_with_index { |itm, idx| tag = 'h'+(idx+1).to_s; headings << content_tag(tag, itm)}
	  raw(headings)
  end

  def html_ul_for(arr)
	  listitems = ''
	  arr.each_with_index { |itm, idx| listitems << content_tag(:li, itm)}
	  raw(content_tag(:ul,raw(listitems)))
  end


  # Produce an Unordered List of Links for Navigation.
  # This may be called recursively.
  #  * ul_opts = HTML options for UL tag
  #  * li_opts = HTML options for LI tags
  #  * link_array = Array of navitems
  # Note that if the Array element value is an Array, then this method will recurse for
  # an indented list.
  def nav_Panel(nav_level,
			link_array )
	  navitems = ''
	  # We have three sets of options: list options, list-item options, and link options.
	  ul_opts = {class: "nav1"}
	  li_opts = {class: "nav level#{nav_level}"}
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
  
end
