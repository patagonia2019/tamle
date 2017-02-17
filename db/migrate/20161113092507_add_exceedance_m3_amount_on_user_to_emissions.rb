class AddExceedanceM3AmountOnUserToEmissions < ActiveRecord::Migration[5.0]
  def change
    add_column :emissions, :exceedance_m3_amount_on_user, :decimal
  end
end
