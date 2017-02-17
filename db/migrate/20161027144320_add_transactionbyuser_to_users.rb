class AddTransactionbyuserToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :transactionbyuser, :boolean
  end
end
