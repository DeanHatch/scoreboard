class Bracketgrouping2 < ActiveRecord::Migration
  def change
	  add_column :groupings, :bracket_grouping, :boolean, default: false, null: false
  end
end
