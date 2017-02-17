class RemoveWaterProvisionAmountOnUserAmountFromEmissions < ActiveRecord::Migration[5.0]
  def change
    remove_column :emissions, :water_provision_amount_on_user_amount, :decimal
  end
end
