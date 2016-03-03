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
    assert_select 'div#<CSS id for error explanation>'
    assert_select 'div.<CSS class for field with error>'
  end

  # this test does the opposite of the last one: checks to see if valid users
  # is added ot the database.
  test "valid signup information" do
    get signup_path
    # assert a difference of 1 in the user count
    assert_difference 'User.count', 1 do
      # this method arranges to follow the redirect after submission, resulting
      # in a rendering of the new user page.
      post_via_redirect users_path, user: { name: "Example User",
                                            email: "user@example.com",
                                            password: "password",
                                            password_confirmation: "password" }
    end
    assert_template 'users/show'
    assert_not flash.empty?
  end

end
