class AddExceedanceM3ByUserToEmissions < ActiveRecord::Migration[5.0]
  def change
    add_column :emissions, :exceedance_m3_by_user, :integer
  end
end
