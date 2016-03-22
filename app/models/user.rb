class User < ActiveRecord::Base

  # the key word attr_accessor creates both a setter and a getter method for our
  # virtual variables.
  attr_accessor :remember_token, :activation_token, :reset_token

  # this callback method makes sure all emails are converted to lowercase BEFORE
  # being saved to the database. Some database adapters use case-sensitive indices
  # but we will prevent that from happening by using the before_save() method.
  before_save :downcase_email
  before_create :create_activation_digest

  # this is the method that is called when we test using @user.valid?
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true,
                    length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

  # method to create a secure password. This catches nil passwords in the
  # creation phase and also stores hashed passwords
  has_secure_password
  # this one allows nil passwords for an edited users attributes hash
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

  # This is one of the many ways to define class methods. See prior commit
  # for original version
  class << self
    # this method will be used to help create a user fixture for integration tests
    # returns the hash digest of the given string. It is set up as a class method
    # since we need to be able to use it without a User instance (in testing)
    def digest(string)
      # this line optimizes so we use the minimum hashing cost for testing purposes
      # but secure enough cost in production
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                    BCrypt::Engine.cost
      BCrypt::Password.create(string, cost: cost)
    end

    def new_token
      # use the SecureRandom module from the standard Ruby library to generate
      # a length-22 random string with each character having 64 distinct possibilities.
      # The chances of user token collisions is minimal.
      SecureRandom.urlsafe_base64
    end
  end

  # remembers a user in the database for use in persistent sessions
  def remember
    # call our class method to generate a new token
    self.remember_token = User.new_token
    # this method bypasses validation so we can update the remember_digest hash
    # without having to login as the user. We use the other class method, User.digest,
    # to hash the token before storing it.
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # this method is used for email authentication before activating a new account,
  # and also for login authentication via a long term cookie installed in the
  # user's computer.
  def authenticated?(attribute, token)
    # here the attribute can be either remember or activation
    digest = send("#{attribute}_digest")
    # return false if there is no digest to compare to
    return false if digest.nil?
    # compare hashed digest to remember_token or activation_token to see if they
    # match, using BCrypt's built-in methods. remember_digest and activation_digest
    # are user attributes from the db table.
    BCrypt::Password.new(digest).is_password?(token)
  end

  # forgets the user (AKA logs out)
  def forget
    update_attribute(:remember_digest, nil)
  end

  # activates and account
  def activate
    update_attribute(:activated, true)
    update_attribute(:activated_at, Time.zone.now)
  end

  # sends activation email
  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end

  # sets the password resets attributes
  def create_reset_digest
    self.reset_token = User.new_token
    update_attribute(:reset_digest, User.digest(reset_token))
    update_attribute(:reset_sent_at, Time.zone.now)
  end

  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end

  def password_reset_expired?
    # this means "reset sent earlier than 2 hours ago", returning true
    # if the request is expired
    reset_sent_at < 2.hours.ago
  end

  # private methods can only be called within the class
  private

    def downcase_email
      self.email = email.downcase # the word self is optional on the right side
      # could also be written as
      #email.downcase!
    end

    def create_activation_digest
      self.activation_token = User.new_token
      self.activation_digest = User.digest(activation_token)
    end

end
