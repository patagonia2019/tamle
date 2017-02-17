class AddMeditionbyuserToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :meditionbyuser, :boolean
  end
end
