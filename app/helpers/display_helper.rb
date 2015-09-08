module DisplayHelper

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
