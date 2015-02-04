class CreateContestants < ActiveRecord::Migration
  def change
    create_table :contestants do |t|
      t.integer :competition_id
      t.string :type
      t.integer :contest_id
      t.string :contest_type
      t.string :homeaway
      t.integer :team_id
      t.integer :score
      t.boolean :forfeit
      t.string :contestanttype
      t.integer :seeding
      t.integer :bracketcontest_id
      t.integer :grouping_id
      t.integer :place

      t.timestamps
    end
  end
end
