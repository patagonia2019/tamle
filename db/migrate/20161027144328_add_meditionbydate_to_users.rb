class AddMeditionbydateToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :meditionbydate, :boolean
  end
end
