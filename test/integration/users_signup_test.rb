require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

  # because the deliveries array is global, we have to reset it to empty here
  # so we can change that it contains one delivery later in the tests. If another
  # test results in deliveries and we don't reset it here, we will have an
  # unexpectedly failing test.
  def setup
    ActionMailer::Base.deliveries.clear
  end

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
    # make sure errors display properly
    assert_select 'div#error_explanation'
    assert_select 'div.field_with_errors'
  end

  # this test does the opposite of the last one: checks to see if valid users
  # is added to the database.
  test "valid signup information with account activation" do
    get signup_path
    # assert a difference of 1 in the user count
    assert_difference 'User.count', 1 do
      post users_path, user: { name: "Example User",
                               email: "user@example.com",
                               password: "password",
                               password_confirmation: "password" }
    end
    assert_equal 1, ActionMailer::Base.deliveries.size
    # the assigns() method lets us use an instance variable from the corresponding
    # controller action we are in right now. In this case we are accessing the
    # @user variable for user here.
    user = assigns(:user)
    assert_not user.activated?
    assert_not flash.empty?
    # try to log in before activation
    log_in_as(user)
    assert_not is_logged_in?
    # invalid activation token
    get edit_account_activation_path(user.activation_token, email:'wrong')
    assert_not is_logged_in?
    # valid activation token
    get edit_account_activation_path(user.activation_token, email: user.email)
    assert user.reload.activated?
    follow_redirect!
    assert_template 'users/show'
    assert is_logged_in?
  end

end
