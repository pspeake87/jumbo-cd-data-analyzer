class AddTermtoNewCd < ActiveRecord::Migration
  def change
    add_column :new_cds, :new_term, :integer
  end
end
