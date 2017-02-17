class Transaction < ApplicationRecord
  belongs_to :user
  mount_uploader :picture, PictureUploader
  validates :concept, length: { maximum: 140 }, presence: true
  validates :user_id, presence: true
  validates :amount, presence: true
  validates :at_date, presence: true
  validate  :picture_size
  scope :user, -> (user) { where user: user }

  private

    # Validates the size of an uploaded picture.
    def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture, "should be less than 5MB")
      end
    end

end
