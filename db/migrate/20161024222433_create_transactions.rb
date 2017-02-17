class CreateTransactions < ActiveRecord::Migration[5.0]
  def change
    create_table :transactions do |t|
      t.integer :user_id
      t.date :at_date
      t.string :concept
      t.decimal :amount
      t.boolean :is_credit

      t.timestamps
    end
  end
end
