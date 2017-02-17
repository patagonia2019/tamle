class AddBilledToTransaction < ActiveRecord::Migration[5.0]
  def change
    add_column :transactions, :billed, :boolean
  end
end
