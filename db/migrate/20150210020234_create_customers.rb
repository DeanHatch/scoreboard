class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.string :userid
      t.string :hashed_password
      t.string :salt

      t.timestamps
    end
  end
end
