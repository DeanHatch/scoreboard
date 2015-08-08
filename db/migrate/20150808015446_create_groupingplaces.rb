class CreateGroupingplaces < ActiveRecord::Migration
  def change
    create_table :groupingplaces do |t|
      t.integer :grouping_id
      t.integer :place

      t.timestamps
    end
  end
end
