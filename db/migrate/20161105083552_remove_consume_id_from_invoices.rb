class RemoveConsumeIdFromInvoices < ActiveRecord::Migration[5.0]
  def change
    remove_column :invoices, :consume_id, :decimal
  end
end
