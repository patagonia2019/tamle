class AddSiaDateToEmissions < ActiveRecord::Migration[5.0]
  def change
    add_column :emissions, :sia_date, :date
  end
end
