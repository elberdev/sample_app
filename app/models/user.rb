class User < ActiveRecord::Base
  # this is the method that is called when we test using @user.valid?
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 }
end
