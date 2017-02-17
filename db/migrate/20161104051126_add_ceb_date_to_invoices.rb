class AddCebDateToInvoices < ActiveRecord::Migration[5.0]
  def change
    add_column :invoices, :ceb_date, :date
  end
end
