class RemoveTransactionbydateFromUsers < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :transactionbydate, :boolean
  end
end
