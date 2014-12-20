class Addcolumntocompetitions < ActiveRecord::Migration
  def change
	  add_column :competitions, :playoffbracket, :integer
  end
end
