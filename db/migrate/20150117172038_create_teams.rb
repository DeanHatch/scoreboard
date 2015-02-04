class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.integer :competition_id
      t.string :name
      t.integer :grouping_id

      t.timestamps
    end
  end
end
