class CreateContests < ActiveRecord::Migration
  def change
    create_table :contests do |t|
      t.date :date
      t.time :time
      t.integer :venue_id
      t.string :status

      t.timestamps
    end
  end
end
