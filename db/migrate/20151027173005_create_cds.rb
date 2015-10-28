class CreateCds < ActiveRecord::Migration
  def change
    create_table :cds do |t|
      
      t.decimal :old_rate
      t.integer :principal
      t.datetime :maturity_date
      t.integer :old_ewp
      t.decimal :old_fee

      t.timestamps null: false
    end
  end
end
