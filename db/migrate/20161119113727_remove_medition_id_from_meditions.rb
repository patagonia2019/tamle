class RemoveMeditionIdFromMeditions < ActiveRecord::Migration[5.0]
  def change
    remove_column :meditions, :medition_id, :integer
  end
end
