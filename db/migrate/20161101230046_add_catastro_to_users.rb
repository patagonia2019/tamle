class AddCatastroToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :catastro, :string
  end
end
