class AddTransactionbyamountToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :transactionbyamount, :boolean
  end
end
