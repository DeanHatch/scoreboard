class CreateCredits < ActiveRecord::Migration
  def change
    create_table :credits do |t|
      t.string :type
      t.integer :customer_id, null: false
      t.timestamps null: false
    end
  end
end
