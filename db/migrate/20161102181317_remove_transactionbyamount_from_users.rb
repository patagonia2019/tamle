class RemoveTransactionbyamountFromUsers < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :transactionbyamount, :boolean
  end
end
