class AddBanknameToCds < ActiveRecord::Migration
  def change
    add_column :cds, :bankname, :string
    
    
  end
end
