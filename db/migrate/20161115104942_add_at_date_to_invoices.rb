class AddAtDateToInvoices < ActiveRecord::Migration[5.0]
  def change
    add_column :invoices, :at_date, :date
  end
end
