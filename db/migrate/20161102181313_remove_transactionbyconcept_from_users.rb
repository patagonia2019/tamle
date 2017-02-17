class RemoveTransactionbyconceptFromUsers < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :transactionbyconcept, :boolean
  end
end
