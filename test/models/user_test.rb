require 'test_helper'

class UserTest < ActiveSupport::TestCase

  # this method creates a User instance variable for us to test
  def setup
    @user = User.new(name: "Example User", email: "user@example.com")
  end

  # this method tests if the user instance variable is valid according to our constraints
  test "should be valid" do
    assert @user.valid?
  end

  test "name should be present" do
    @user.name = "     "
    assert_not @user.valid?
  end

end
