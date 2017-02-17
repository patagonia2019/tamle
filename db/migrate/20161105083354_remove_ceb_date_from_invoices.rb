class RemoveCebDateFromInvoices < ActiveRecord::Migration[5.0]
  def change
    remove_column :invoices, :ceb_date, :decimal
  end
end
