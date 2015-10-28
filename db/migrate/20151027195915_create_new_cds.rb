class CreateNewCds < ActiveRecord::Migration
  def change
    create_table :new_cds do |t|
      t.decimal :new_rate
      t.decimal :new_fee

      t.timestamps null: false
    end
  end
end
