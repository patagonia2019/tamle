class RemoveSocialQuoteAmountFromInvoices < ActiveRecord::Migration[5.0]
  def change
    remove_column :invoices, :social_quote_amount, :decimal
  end
end
