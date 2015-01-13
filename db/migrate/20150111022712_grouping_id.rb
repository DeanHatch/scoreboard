class GroupingId < ActiveRecord::Migration
  def change
	  remove_column :groupings, :grouping_id
  end
end
