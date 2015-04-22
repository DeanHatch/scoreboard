module GroupingsHelper

  # Produce an Unordered List of Links for Navigation.
  # This may be called recursively.
  #  * ul_opts = HTML options for UL tag
  #  * li_opts = HTML options for LI tags
  #  * link_hsh = hash where key is hyperlink text and value is hyperlink target
  # Note that if the hash value is a Hash, then this method will recurse for
  # an indented list.
  # Return this Grouping as a LI (listitem)
  # followed by any subgroupings below it as an UnorderedList.
  def nested_groupings(grp_level, grouping)
	  ul_opts = {class: "nav1"}
	  li_opts = {class: "nav level#{grp_level}"}
	  link_opts = {class: "nav"}  # , target: "_blank"}
	  subgrpitems = ''
	  my_link_path = raw(edit_grouping_path(grouping))
	  #itemval = grouping.parent_id ? link_to( grouping.name, my_link_path, link_opts)  :  grouping.name
	  itemval = link_to( grouping.name, my_link_path, link_opts)
	  itemval << ' (This is a Bracket Grouping)' if grouping.bracket_grouping
	  itemval << raw(content_tag(:em, (' - Teams: ' + grouping.teams.collect{|t| t.name}.join(', ')))) if grouping.has_teams?
	  grpitem = raw(content_tag(:li, raw(itemval), li_opts))
	  subgrpitems = raw(grouping.subgroupings.collect{ |sbgrp| nested_groupings(grp_level + 1, sbgrp) }.join )
	  grouping.has_subgroupings? ? grpitem + raw(content_tag(:ul, subgrpitems, ul_opts)) : grpitem
  end

end
