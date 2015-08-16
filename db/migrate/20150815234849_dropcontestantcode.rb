class Dropcontestantcode < ActiveRecord::Migration
  def change
	  remove_column :contestants, :contestantcode
  end
end
