class Stages4competitions < ActiveRecord::Migration
  def change
	  change_column :competitions, :poolgroupseason, :boolean
	  change_column :competitions, :playoffbracket, :boolean
	  add_column :competitions, :poolgroupseasonlabel, :string
	  add_column :competitions, :playoffbracketlabel, :string
  end
end
