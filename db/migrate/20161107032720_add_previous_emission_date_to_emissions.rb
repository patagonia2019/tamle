class AddPreviousEmissionDateToEmissions < ActiveRecord::Migration[5.0]
  def change
    add_column :emissions, :previous_emission_date, :date
  end
end
