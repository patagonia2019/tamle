class RemovePreviousEmissionDateFromEmissions < ActiveRecord::Migration[5.0]
  def change
    remove_column :emissions, :previous_emission_date, :date
  end
end
