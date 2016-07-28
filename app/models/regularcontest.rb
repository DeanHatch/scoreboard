# Regularcontest is a faily simple class which adds little to the
# basic Contest class.
class Regularcontest < Contest
	
  validates :competition_id,
		:homecontestant,
		:awaycontestant,
		presence: true

end
