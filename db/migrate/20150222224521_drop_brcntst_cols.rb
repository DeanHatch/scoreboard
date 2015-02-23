class DropBrcntstCols < ActiveRecord::Migration
  def change
	  remove_column :contestants, :bracketcontest_id
	  remove_column :contestants, :grouping_id
	  remove_column :contestants, :place
  end
end
