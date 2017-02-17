class AddBilledToEmissions < ActiveRecord::Migration[5.0]
  def change
    add_column :emissions, :billed, :boolean
  end
end
