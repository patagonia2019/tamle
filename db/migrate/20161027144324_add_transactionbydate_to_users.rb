class AddTransactionbydateToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :transactionbydate, :boolean
  end
end
