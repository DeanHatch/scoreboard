module DisplayHelper

  def team_link_for(team)
    link_to team.name, display_team_path(@competition, team)
  end
  

  
  def scores_by_type(collectn)
    moreThanOneType = (collectn.collect{|c|c.type}.uniq.size()>1) 
    lastType = nil
    collectn.inject(' '){|result, cntst|
      if moreThanOneType && cntst.type != lastType
	lastType = cntst.type()
        raw(result  +
          raw(content_tag(:tr, raw(content_tag(:th, group_results_section_label(cntst.competition,cntst.type() ),
	                                                         class: "typeBanner", colspan: "#{yield.size()}" )) ) ) )
      else
        result
       end +
       raw(content_tag(:tr,raw(yield.collect{|x|raw(content_tag(:td, cntst.send(x))) }.join("\n ") )))
       }
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
  
  def group_schedule_section_label(comp, type)
    (case type
        when "Regularcontest"
	  comp.poolgroupseasonlabel()
	when "Bracketcontest"
	  comp.playoffbracketlabel()
	else
	  "Other"
	end).to_s+" Contests"
  end
  
  def group_results_section_label(comp, type)
    (case type
        when "Regularcontest"
	  comp.poolgroupseasonlabel()
	when "Bracketcontest"
	  comp.playoffbracketlabel()
	else
	  "Other"
	end).to_s+" Results"
  end
  
end
