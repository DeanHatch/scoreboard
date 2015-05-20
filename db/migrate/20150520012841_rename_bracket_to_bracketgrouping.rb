class RenameBracketToBracketgrouping < ActiveRecord::Migration
  def change
	  rename_column(:contests, :bracket_id, :bracketgrouping_id)
  end
end
