class AddTransactionbyconceptToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :transactionbyconcept, :boolean
  end
end
