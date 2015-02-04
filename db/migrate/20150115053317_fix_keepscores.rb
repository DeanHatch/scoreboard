class FixKeepscores < ActiveRecord::Migration
  def change
	  rename_column :competitions, :kepscores, :keepscores
  end
end
