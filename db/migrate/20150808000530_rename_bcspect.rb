class RenameBcspect < ActiveRecord::Migration
  def change
  rename_column :contestants, :bcspect_type, :bcspec_type
  end
end
