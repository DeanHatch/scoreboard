class CreateBspec < ActiveRecord::Migration
  def change
    add_column :contestants, :bcspect_type, :string
    add_column :contestants, :bcspec_id, :integer 
  end
end
