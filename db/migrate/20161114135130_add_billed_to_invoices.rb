class AddBilledToInvoices < ActiveRecord::Migration[5.0]
  def change
    add_column :invoices, :billed, :boolean
  end
end
