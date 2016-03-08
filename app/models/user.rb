class User < ActiveRecord::Base

  # this callback method makes sure all emails are converted to lowercase BEFORE
  # being saved to the database. Some database adapters use case-sensitive indices
  # but we will prevent that from happening by using the before_save() method.
  before_save { self.email = email.downcase } # the word self is optional on the right side
  # could also be written as
  #before_save { email.downcase! }

  # this is the method that is called when we test using @user.valid?
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true,
                    length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

  # method to create a secure password
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }

  # this method will be used to help create a user fixture for integration tests
  # returns the hash digest of the given string
  def User.digest(string)

    # this line optimizes so we use the minimum hashing cost for testing purposes
    # but secure enough cost in production
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
end
