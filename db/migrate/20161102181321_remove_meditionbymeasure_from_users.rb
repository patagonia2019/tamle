class RemoveMeditionbymeasureFromUsers < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :meditionbymeasure, :boolean
  end
end
