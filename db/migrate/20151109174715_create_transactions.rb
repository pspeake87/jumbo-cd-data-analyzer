class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.string :bankname
      t.decimal :old_fee
      t.integer :principal
      t.decimal :old_rate
      t.datetime :maturity_date
      t.integer :old_penalty
      t.datetime :start_date

      t.timestamps null: false
    end
  end
end
