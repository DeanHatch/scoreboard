class AddCustomerId < ActiveRecord::Migration
  def change
	  add_column :competitions, :customer_id, :integer
  end
end
