class AddUserToNewCds < ActiveRecord::Migration
  def change
    add_column :new_cds, :user_id, :integer
    add_index :new_cds, :user_id
  end
end
