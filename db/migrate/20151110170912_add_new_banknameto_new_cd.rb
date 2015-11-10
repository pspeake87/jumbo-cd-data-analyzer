class AddNewBanknametoNewCd < ActiveRecord::Migration
  def change
     add_column :new_cds, :new_bankname, :string
  end
end
