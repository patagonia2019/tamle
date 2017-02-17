class AddBilledDateToInvoices < ActiveRecord::Migration[5.0]
  def change
    add_column :invoices, :billed_date, :date
  end
end
