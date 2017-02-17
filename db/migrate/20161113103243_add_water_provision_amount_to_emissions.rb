class AddWaterProvisionAmountToEmissions < ActiveRecord::Migration[5.0]
  def change
    add_column :emissions, :water_provision_amount, :decimal
  end
end
