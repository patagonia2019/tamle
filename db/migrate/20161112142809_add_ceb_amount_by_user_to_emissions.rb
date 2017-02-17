class AddCebAmountByUserToEmissions < ActiveRecord::Migration[5.0]
  def change
    add_column :emissions, :ceb_amount_by_user, :decimal
  end
end
