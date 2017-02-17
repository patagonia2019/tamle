class RemoveEmissionIdFromTransactions < ActiveRecord::Migration[5.0]
  def change
    remove_column :transactions, :emission_id, :integer
  end
end
