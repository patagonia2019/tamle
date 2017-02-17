class AddBilledToMeditions < ActiveRecord::Migration[5.0]
  def change
    add_column :meditions, :billed, :boolean
  end
end
