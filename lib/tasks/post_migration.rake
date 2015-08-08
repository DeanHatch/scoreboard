namespace :bcspec do
  desc "TODO"
  task populate: :environment do
    p "Howdy"
    puts Bracketcontestant.all.first.methods.sort.join(" ")
    Bracketcontestant.all.each{|bc|
						case bc.contestanttype
						  when "G"
						    bc.bcspec = Groupingplace.new()
 						    /G(\d+)P(\d+)/ =~ bc.contestantcode
						    bc.bcspec.grouping = Grouping.find(Regexp.last_match(1))
						    bc.bcspec.place = Regexp.last_match(2)
						  when "W"
						    bc.bcspec = Priorbracketcontest.new()
 						    /W(\d+)/ =~ bc.contestantcode
						    bc.bcspec.bracketcontest = Bracketcontest.find(Regexp.last_match(1))
						    bc.bcspec.wl = "W"
						  when "L"
						    bc.bcspec = Priorbracketcontest.new()
						    /L(\d+)/ =~ bc.contestantcode
						    bc.bcspec.bracketcontest = Bracketcontest.find(Regexp.last_match(1))
						    bc.bcspec.wl = "L"
						  else 
						    nil
						end
                                                puts bc.contestantcode().inspect() + bc.contestanttype().inspect() + bc.bcspec_type.inspect() + bc.bcspec.inspect()}
  end

end
