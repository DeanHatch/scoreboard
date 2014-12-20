class Dropcontestants < ActiveRecord::Migration
  def change
	  drop_table :contestants
  end
end
