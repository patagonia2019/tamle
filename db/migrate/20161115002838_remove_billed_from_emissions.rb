class RemoveBilledFromEmissions < ActiveRecord::Migration[5.0]
  def change
    remove_column :emissions, :billed, :boolean
  end
end
