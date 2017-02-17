class AddMeditionbymeasureToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :meditionbymeasure, :boolean
  end
end
