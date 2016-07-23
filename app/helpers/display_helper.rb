module DisplayHelper

  def team_link_for(team)
    link_to team.name, display_team_path(@competition, team)
  end
  

  
  def scores_by_type(collectn, columnArray)
    contests_by_type(collectn, columnArray, "Results" )
  end
  
  def contests_by_type(collectn, columnArray, label)
    moreThanOneType = (collectn.collect{|c|c.type}.uniq.size()>1) 
    lastType = nil
    collectn.inject(' '){|result, cntst|
      if moreThanOneType && cntst.type != lastType
	lastType = cntst.type()
        result  +
          content_tag(:tr, content_tag(:th, group_section_label(cntst.competition,cntst.type(), label),
	                                                         class: "typeBanner", colspan: "#{columnArray.size()}" ))
      else
        result
       end +
       content_tag(:tr,columnArray.collect{|x|content_tag(:td, cntst.send(x), class: "schedule") }.join("\n ").html_safe )
       }
  end
  
  def group_schedule_section_label(comp, type)
    group_section_label(comp, type, "Contests")
  end
  
  def group_results_section_label(comp, type)
    group_section_label(comp, type, "Results")
  end
  
  def group_section_label(comp, type, label)
    (case type
        when "Regularcontest"
	  comp.poolgroupseasonlabel()
	when "Bracketcontest"
	  comp.playoffbracketlabel()
	else
	  "Other"
	end).to_s+" " + label
  end

  def standings_headers(comp)
   raw(comp.result_headings.collect{|rh| raw(content_tag(:th, rh))}.join(" ") )
  end

  def standings_row(comp, team)
   raw(comp.result_row.collect{|rr| raw(content_tag(:td, team.send(rr)))}.join(" ") )
  end
 
  def group_schedule_headers(comp)
   raw(comp.result_headings.collect{|rh| raw(content_tag(:th, rh))}.join(" ") )
  end

  def group_schedule_row(comp, team)
   raw(comp.result_row.collect{|rr| raw(content_tag(:td, team.send(rr)))}.join(" ") )
  end
  
end
