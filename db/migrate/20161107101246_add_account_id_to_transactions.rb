class AddAccountIdToTransactions < ActiveRecord::Migration[5.0]
  def change
    add_column :transactions, :account_id, :integer
  end
end
