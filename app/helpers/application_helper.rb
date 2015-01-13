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

  # Produce and Unordered List of Links for Navigation.
  def link_hsh()
     { 'Manage Dates/Venues' => :venues,
	'Manage Groupings' => :groupings,
	'Manage Teams' => :teams,
	'Schedule Regular Contests' => :regularcontests,
	'Schedule Bracket Contests' => :bracketcontests,
	'Record/Revise Scores' => :scorer,
	'Public Display' => :display  }
  end

  # Produce and Unordered List of Links for Navigation.
  def navPanel()
	  navitems = ''
	  #navitems = self.controller.controller_name().humanize
	  self.link_hsh.each { |lbl, trgt| navitems << content_tag(:li,
										  link_to( lbl, trgt, class: "nav"),
										  class: "nav level1")}
	  raw(content_tag(:ul, raw(navitems), class: "nav1"))
  end

end
