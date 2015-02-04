class Removecontests < ActiveRecord::Migration
  def change
	  drop_table :contestants
	  drop_table :contests
  end
end
