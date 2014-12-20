class Regularcontest < Contest
	has_one :homecontestant, -> { where homeaway: 'H' },
						class_name: "Regularcontestant",
						foreign_key: "contest_id"
	has_one :awaycontestant, -> { where homeaway: 'A' },
						class_name: "Regularcontestant",
						foreign_key: "contest_id"
end
