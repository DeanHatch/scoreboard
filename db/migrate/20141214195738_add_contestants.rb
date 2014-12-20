class AddContestants < ActiveRecord::Migration
  def change
	  add_column :contests, :homecontestant_id, :integer
	  add_column :contests, :awaycontestant_id, :integer
  end
end
