class AddContestTypes < ActiveRecord::Migration
  def change
	  add_column :contests, :type, :string
	  add_column :contestants, :type, :string
  end
end
