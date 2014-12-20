class Bracketcontest < Contest
	has_one :homecontestant, -> { where homeaway: 'H' },
						class_name: "Bracketcontestant",
						foreign_key: "contest_id"
	has_one :awaycontestant, -> { where homeaway: 'A' },
						class_name: "Bracketcontestant",
						foreign_key: "contest_id"
end
