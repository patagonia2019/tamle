class Emission < ApplicationRecord
  validates_presence_of :medition_id, :previous_medition_id, :at_emission_date, :consume_id, :water_previous_measure, :water_measure, :water_consumed, :exceedance_m3, :exceedance_amount, :ceb_date, :ceb_amount, :social_quote_amount, :balance_previous_amount, :balance_amount
	validates_presence_of :balance_previous_date, :allow_nil => true
	validates_presence_of :payment_date, :allow_nil => true
end
