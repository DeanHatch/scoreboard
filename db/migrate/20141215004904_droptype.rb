class Droptype < ActiveRecord::Migration
  def change
	  remove_column :contests, :type
  end
end
