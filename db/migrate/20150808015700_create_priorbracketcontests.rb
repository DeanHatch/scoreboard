class CreatePriorbracketcontests < ActiveRecord::Migration
  def change
    create_table :priorbracketcontests do |t|
      t.integer :bracketcontest_id
      t.string :wl

      t.timestamps
    end
  end
end
