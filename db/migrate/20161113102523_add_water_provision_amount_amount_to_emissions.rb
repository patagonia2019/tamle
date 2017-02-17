class AddWaterProvisionAmountAmountToEmissions < ActiveRecord::Migration[5.0]
  def change
    add_column :emissions, :water_provision_amount_amount, :decimal
  end
end
