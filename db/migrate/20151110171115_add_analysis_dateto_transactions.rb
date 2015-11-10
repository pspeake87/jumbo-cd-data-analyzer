class AddAnalysisDatetoTransactions < ActiveRecord::Migration
  def change
    add_column :transactions, :analysis_date, :date
  end
end
