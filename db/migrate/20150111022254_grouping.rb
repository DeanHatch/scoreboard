class Grouping < ActiveRecord::Migration
  def change
	  remove_column :grouping, :grouping_id
  end
end
