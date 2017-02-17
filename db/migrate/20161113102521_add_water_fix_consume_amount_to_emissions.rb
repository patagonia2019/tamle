class AddWaterFixConsumeAmountToEmissions < ActiveRecord::Migration[5.0]
  def change
    add_column :emissions, :water_fix_consume_amount, :decimal
  end
end
