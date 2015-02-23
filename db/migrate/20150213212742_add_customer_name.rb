class AddCustomerName < ActiveRecord::Migration
  def change
	  add_column :customers, :name, :string
	  add_column :customers, :phone, :string
	  add_column :customers, :website, :string
  end
end
