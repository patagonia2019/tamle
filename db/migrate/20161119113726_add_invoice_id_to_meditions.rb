class AddInvoiceIdToMeditions < ActiveRecord::Migration[5.0]
  def change
    add_column :meditions, :invoice_id, :integer
  end
end
