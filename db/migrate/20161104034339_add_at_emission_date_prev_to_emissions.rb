class AddAtEmissionDatePrevToEmissions < ActiveRecord::Migration[5.0]
  def change
    add_column :emissions, :at_emission_date_prev, :date
  end
end
