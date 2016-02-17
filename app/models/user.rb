class User < ActiveRecord::Base
  # this is the method that is called when we test using @user.valid?
  validates :name, presence: true
end
