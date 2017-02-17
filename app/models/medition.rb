class Medition < ApplicationRecord
	belongs_to :user
	validates :at_date, presence: true
	validates :measure, presence: true
  scope :user, -> (user) { where user: user }

end
