module DisplayHelper

  def standings_headers(comp)
   raw(comp.result_headings.collect{|rh| raw(content_tag(:th, rh))}.join(" ") )
  end

  def standings_row(comp, team)
   raw(comp.result_row.collect{|rr| raw(content_tag(:td, team.send(rr)))}.join(" ") )
  end
  
end
