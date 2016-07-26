class CreateValidTimes < ActiveRecord::Migration
  def change
    create_table :valid_times do |t|
      t.integer :competition_id
      t.integer :grouping_id
      t.integer :venue_id
      t.integer :from_time
      t.integer :to_time

      t.timestamps null: false
    end
  end
end
