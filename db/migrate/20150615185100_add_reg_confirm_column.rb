class AddRegConfirmColumn < ActiveRecord::Migration
  def change
	  add_column :customers, :reg_confirm_token, :string
  end
end
