class AddAtEmissionDateCurrentToEmissions < ActiveRecord::Migration[5.0]
  def change
    add_column :emissions, :at_emission_date_current, :date
  end
end
