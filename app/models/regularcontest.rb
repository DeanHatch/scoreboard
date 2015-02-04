# Regularcontest is a faily simple class which adds little to the
# basic Contest class.
class Regularcontest < Contest
	
	has_one :homecontestant, -> { where homeaway: 'H' },
						class_name: "Regularcontestant",
						foreign_key: "contest_id"
	has_one :awaycontestant, -> { where homeaway: 'A' },
						class_name: "Regularcontestant",
						foreign_key: "contest_id"
	
	accepts_nested_attributes_for :homecontestant, :awaycontestant, allow_destroy: true , update_only: true
	
		

end
