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
  #  * link_hsh = hash where key is hyperlink text and value is hyperlink target
  # Note that if the hash value is a Hash, then this method will recurse for
  # an indented list.
  def nav_panel(nav_level,
			link_hsh )
	  navitems = ''
	  ul_opts = {class: "nav1"}
	  li_opts = {class: "nav level#{nav_level}"}
	  link_opts = {class: "nav", target: "_blank"}
	  link_hsh.each { |lbl, trgt| trgt.class.name == "Hash" ? 
						navitems << nav_panel(nav_level + 1, trgt) :
						navitems << content_tag(:li,
										  link_to( lbl, trgt, link_opts),
										  li_opts)
						}
	  raw(content_tag(:ul, raw(navitems), ul_opts))
  end


  # Start the process to produce a (nested) Unordered List of Links for Navigation.
  def navPanel()
	  nav_panel(1, controller.nav_link_hash)
  end

end
