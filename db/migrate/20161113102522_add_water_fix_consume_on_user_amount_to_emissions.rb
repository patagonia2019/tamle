class AddWaterFixConsumeOnUserAmountToEmissions < ActiveRecord::Migration[5.0]
  def change
    add_column :emissions, :water_fix_consume_on_user_amount, :decimal
  end
end
