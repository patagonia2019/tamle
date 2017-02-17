class Consume < ApplicationRecord
	validates :at_date, presence: true
	validates :water_fix_consume_amount, presence: true
	validates :water_provision_amount, presence: true
	validates :exceedance_m3, presence: true
	validates :exceedance_m3_amount, presence: true
end
