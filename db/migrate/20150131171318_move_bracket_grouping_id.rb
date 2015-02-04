class MoveBracketGroupingId < ActiveRecord::Migration
  def change
	  remove_column :contestants, :bracket_grouping_id
	  add_column :contests, :bracket_grouping_id, :integer
  end
end
