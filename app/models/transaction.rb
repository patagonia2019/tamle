class Transaction < ApplicationRecord
  belongs_to :user
  mount_uploader :picture, PictureUploader
  has_attached_file :facturaoriginal, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :facturaoriginal, content_type: [/\Aimage\/.*\z/ , "application/pdf"]
  validates_attachment_file_name :facturaoriginal, matches: [/png\z/, /jpe?g\z/, /pdf\z/]


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
