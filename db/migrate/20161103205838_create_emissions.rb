class CreateEmissions < ActiveRecord::Migration[5.0]
  def change
    create_table :emissions do |t|
      t.integer :medition_id
      t.integer :previous_medition_id
      t.date :at_emission_date
      t.integer :consume_id
      t.integer :water_previous_measure
      t.integer :water_measure
      t.integer :water_consumed
      t.integer :exceedance_m3
      t.decimal :exceedance_amount
      t.date :ceb_date
      t.decimal :ceb_amount
      t.decimal :social_quote_amount
      t.decimal :balance_previous_amount
      t.date :balance_previous_date
      t.decimal :payment_amount
      t.date :payment_date
      t.decimal :balance_amount

      t.timestamps
    end
  end
end
