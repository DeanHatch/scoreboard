class DefaultKeepscores < ActiveRecord::Migration
  def change
	  change_column_default :competitions, :keepscores, true
  end
end
