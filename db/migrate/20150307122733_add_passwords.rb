class AddPasswords < ActiveRecord::Migration
  def change
	  add_column :competitions, :hashed_manager_password, :string
	  add_column :competitions, :hashed_scorer_password, :string
  end
end
