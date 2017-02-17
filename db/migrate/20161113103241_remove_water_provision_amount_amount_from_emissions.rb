class RemoveWaterProvisionAmountAmountFromEmissions < ActiveRecord::Migration[5.0]
  def change
    remove_column :emissions, :water_provision_amount_amount, :decimal
  end
end
