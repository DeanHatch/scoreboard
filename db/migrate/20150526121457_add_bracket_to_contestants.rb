class AddBracketToContestants < ActiveRecord::Migration
  def change
	  add_column :contestants, :bracketgrouping_id, :integer
  end
end
