require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

  test "invalid signup information" do

    # double check signup renders with no problem
    get signup_path

    # we post an invalid new user and make sure it does not get added to the
    # database.
    assert_no_difference 'User.count' do
      post users_path, user: { name: "",
                               email: "user@invalid",
                               password: "foo",
                               password_confirmation: "bar" }
    end

    # check that a failed submission re-renders the users/new action
    assert_template 'users/new'
  end

end
