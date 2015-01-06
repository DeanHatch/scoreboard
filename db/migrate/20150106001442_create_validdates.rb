class CreateValiddates < ActiveRecord::Migration
  def change
    create_table :validdates do |t|
      t.date :gamedate

      t.timestamps
    end
  end
end
