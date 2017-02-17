class AddUserIdToEmissions < ActiveRecord::Migration[5.0]
  def change
    add_column :emissions, :user_id, :integer
  end
end
