class CreateContests < ActiveRecord::Migration
  def change
    create_table :contests do |t|
      t.integer :competition_id
      t.string :type
      t.date :date
      t.integer :time
      t.integer :venue_id
      t.string :status
      t.integer :homecontestant_id
      t.integer :awaycontestant_id

      t.timestamps
    end
  end
end
