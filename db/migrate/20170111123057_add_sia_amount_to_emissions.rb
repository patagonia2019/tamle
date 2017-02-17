class AddSiaAmountToEmissions < ActiveRecord::Migration[5.0]
  def change
    add_column :emissions, :sia_amount, :decimal
  end
end
