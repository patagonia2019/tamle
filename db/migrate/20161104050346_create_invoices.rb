class CreateInvoices < ActiveRecord::Migration[5.0]
  def change
    create_table :invoices do |t|
      t.date :at_emission_date_current
      t.date :at_emission_date_prev
      t.integer :consume_id
      t.decimal :social_quote_amount

      t.timestamps
    end
  end
end
