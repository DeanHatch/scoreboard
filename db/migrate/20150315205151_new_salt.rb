class NewSalt < ActiveRecord::Migration
  def change
	  add_column :competitions, :salt, :string
  end
end
