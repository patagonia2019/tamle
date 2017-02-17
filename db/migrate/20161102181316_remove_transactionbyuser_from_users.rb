class RemoveTransactionbyuserFromUsers < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :transactionbyuser, :boolean
  end
end
