module ContestsHelper

def standings_headings
	[ 'Team', 'Wins', 'Losses']
end

def standings_columns
	[ :name, :id, :id]
end


def schedule_headings
	[ 'Date', 'Time', 'Visitor', 'Home Team', 'Location']
end

def schedule_columns
	[ :display_date, :display_time, :awaycontestant_fullname, :homecontestant_fullname, :venue_name]
end

end
