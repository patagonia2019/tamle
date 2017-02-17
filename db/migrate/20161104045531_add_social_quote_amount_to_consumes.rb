class AddSocialQuoteAmountToConsumes < ActiveRecord::Migration[5.0]
  def change
    add_column :consumes, :social_quote_amount, :decimal
  end
end
