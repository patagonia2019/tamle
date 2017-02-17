class CreateMeditions < ActiveRecord::Migration[5.0]
  def change
    create_table :meditions do |t|
      t.integer :user_id
      t.date :at_date
      t.integer :measure

      t.timestamps
    end
  end
end
