class RemoveMeditionbydateFromUsers < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :meditionbydate, :boolean
  end
end
