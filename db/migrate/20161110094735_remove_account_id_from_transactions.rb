class RemoveAccountIdFromTransactions < ActiveRecord::Migration[5.0]
  def change
    remove_column :transactions, :account_id, :integer
  end
end
