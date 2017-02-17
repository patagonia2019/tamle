class AddNumberOfMembersToConsumes < ActiveRecord::Migration[5.0]
  def change
    add_column :consumes, :number_of_members, :integer
  end
end
