class ChangeOldFeeandNewRateinCds < ActiveRecord::Migration
  def change
    change_column :cds, :old_rate, :decimal, :precision => 2, :scale => 2
    change_column :cds, :old_fee, :decimal, :precision => 2, :scale => 2
  end
end
