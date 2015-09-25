class CreateAlertRequests < ActiveRecord::Migration
  def change
    create_table :alert_requests do |t|
      t.string :type
      t.string :to_dest
      t.string :at_domain
      t.references :team, index: true

      t.timestamps
    end
  end
end
