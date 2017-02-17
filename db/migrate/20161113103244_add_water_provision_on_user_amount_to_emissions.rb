class AddWaterProvisionOnUserAmountToEmissions < ActiveRecord::Migration[5.0]
  def change
    add_column :emissions, :water_provision_on_user_amount, :decimal
  end
end
