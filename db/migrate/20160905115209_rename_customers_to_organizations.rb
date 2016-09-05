class RenameCustomersToOrganizations < ActiveRecord::Migration
  def change
    change_table :customers do |t|
      t.remove :userid, :hashed_password, :salt, :reg_confirm_token
    end
    change_table :competitions do |t|
      t.rename :customer_id, :organization_id
    end
    rename_table :customers, :organizations
  end
end
