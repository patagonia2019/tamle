class AddInvoiceIdToEmissions < ActiveRecord::Migration[5.0]
  def change
    add_column :emissions, :invoice_id, :integer
  end
end
