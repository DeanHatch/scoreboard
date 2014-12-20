class CreateContestants < ActiveRecord::Migration
  def change
    create_table :contestants do |t|
      t.references :contest, polymorphic: true, index: true
      t.string :homeaway
      t.references :team, index: true
      t.integer :score
      t.boolean :forfeit
      t.string :contestanttype
      t.integer :seeding
      t.references :bracketcontest, index: true
      t.references :grouping, index: true
      t.integer :place

      t.timestamps
    end
  end
end
