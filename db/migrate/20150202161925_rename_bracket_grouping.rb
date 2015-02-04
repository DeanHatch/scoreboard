class RenameBracketGrouping < ActiveRecord::Migration
  def change
	  rename_column(:contests, :bracket_grouping_id, :bracket_id)
  end
end
