class RenameContestanttype < ActiveRecord::Migration
  def change
	  rename_column(:contestants, :contestanttype, :contestantcode)
  end
end
