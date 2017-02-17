class AddInvoiceIdToTransactions < ActiveRecord::Migration[5.0]
  def change
    add_column :transactions, :invoice_id, :integer
  end
end
