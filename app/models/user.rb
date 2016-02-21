class User < ActiveRecord::Base

  # this callback method makes sure all emails are converted to lowercase BEFORE
  # being saved to the database. Some database adapters use case-sensitive indices
  # but we will prevent that from happening by using the before_save() method.
  before_save { self.email = email.downcase } # the word self is optional on the right side

  # this is the method that is called when we test using @user.valid?
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true,
                    length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

  # method to create a secure password
  has_secure_password
  
  validates :password, presence: true, length: { minimum: 6 }

end
