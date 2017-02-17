class AddPictureToTransactions < ActiveRecord::Migration[5.0]
  def change
    add_column :transactions, :picture, :string
  end
end
