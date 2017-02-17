class RemoveAtEmissionDateCurrentFromInvoices < ActiveRecord::Migration[5.0]
  def change
    remove_column :invoices, :at_emission_date_current, :date
  end
end
