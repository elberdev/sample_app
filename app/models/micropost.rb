class Micropost < ActiveRecord::Base
  belongs_to :user
  # the default scope sets the order in which entries will be pulled from the
  # database. In this case it's most recent to older
  default_scope -> { order(created_at: :desc) }
  # mount_uploader is a CarrieWave method to associate an image with a model
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  # notice validate keyword instead of validates when doing a custom validation
  validate :picture_size

  private

    # Validates the size of an uploaded picture
    def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture, "should be less than 5MB")
      end
    end

end
