class CreateCompetitions < ActiveRecord::Migration
  def change
    create_table :competitions do |t|
      t.string :name
      t.integer :sport
      t.integer :variety
      t.boolean :poolgroupseason
      t.string :poolgroupseasonlabel
      t.boolean :playoffbracket
      t.string :playoffbracketlabel
      t.boolean :kepscores
      t.integer :winpoints
      t.integer :drawpoints
      t.integer :losspoints
      t.integer :forfeitpoints
      t.integer :forfeitwinscore
      t.integer :forfeitlossscore

      t.timestamps
    end
  end
end
