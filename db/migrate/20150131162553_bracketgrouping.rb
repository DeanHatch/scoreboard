class Bracketgrouping < ActiveRecord::Migration
  def change
	  add_column :groupings, :bracket_grouping, :boolean, null: false
	 # add_column :contestants, :bracket_grouping_id, :integer
  end
end
