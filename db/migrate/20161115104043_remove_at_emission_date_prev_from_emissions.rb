class RemoveAtEmissionDatePrevFromEmissions < ActiveRecord::Migration[5.0]
  def change
    remove_column :emissions, :at_emission_date_prev, :date
  end
end
