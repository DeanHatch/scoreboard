class Makeadvancement < ActiveRecord::Migration
  def change
    rename_column :priorbracketcontests, :bracketcontest_id, :from_contest_id
    rename_table :priorbracketcontests, :bcadvancements
    Bracketcontestant.all.select{|bc| bc.bcspec_type=="Priorbracketcontest"}.each{|bc| bc.bcspec_type="Bcadvancement";bc.save!}
  end
end
