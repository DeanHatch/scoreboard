class CreateGroupings < ActiveRecord::Migration
  def change
    create_table :groupings do |t|
      t.integer :competition_id
      t.string :name
      t.integer :parent_id

      t.timestamps
    end
  end
end
