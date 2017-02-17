class RemoveAtEmissionDateCurrentFromEmissions < ActiveRecord::Migration[5.0]
  def change
    remove_column :emissions, :at_emission_date_current, :date
  end
end
