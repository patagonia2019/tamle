class CreateConsumes < ActiveRecord::Migration[5.0]
  def change
    create_table :consumes do |t|
      t.date :at_date
      t.decimal :water_fix_consume_amount
      t.decimal :water_provision_amount
      t.integer :exceedance_m3
      t.decimal :exceedance_m3_amount

      t.timestamps
    end
  end
end
