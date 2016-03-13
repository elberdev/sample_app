require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest

  def setup
    # takes user fixture from users.yml file and loads it into an instance
    # variable for our testing pleasure.
    @user = users(:michael)
  end

  # test to make sure flash warning about invalid login is only appearing
  # once, on the reloaded new login page only. To get this test to pass we
  # need to user the flash.now variable in instead of flash in
  # sessions_controller.rb
  test "login with invalid information" do
    #load login page
    get login_path
    #check it has loaded properly
    assert_template 'sessions/new'
    #log in with invalid info
    post login_path, session: { email: "", password: "" }
    #check page has reloaded
    assert_template 'sessions/new'
    #check flash message is there
    assert_not flash.empty?
    #load another page
    get root_path
    #check flash message is no longer there
    assert flash.empty?
  end

  test "login with valid information followed by logout" do
    # load login page
    get login_path
    # try a valid login using our fixture. We insert the password here
    # because the password is hashed... but so doesn't that open up a huge
    # vulnerability by me posting a password here (if someone wants to reverse
    # engineer that hashing algorithm)?
    post login_path, session: { email: @user.email, password: 'password' }
    # check to make sure we are logged in
    assert is_logged_in?
    # check that page redirects to user page
    assert_redirected_to @user
    # actually visit the page
    follow_redirect!
    # check that users/show loads properly
    assert_template 'users/show'
    # verify that there are 0 links for login on the page now
    assert_select "a[href=?]", login_path, count: 0
    # check for other links that should be on the page
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", user_path(@user)
    # log out
    delete logout_path
    # make sure we are not logged in
    assert_not is_logged_in?
    # make sure we are redirected to root path
    assert_redirected_to root_url
    # simulate user clicking logout in a second window
    delete logout_path
    # follow the redirect
    follow_redirect!
    # check that all the proper links are there
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", logout_path, count: 0
    assert_select "a[href=?]", user_path(@user), count: 0
  end

  test "login with remembering" do
    log_in_as(@user, remember_me: '1')
    # for some reason the cookies hash here does not work with symbols like
    # cookies[:remember_token], so we plug in the string
    assert_equal cookies['remember_token'], assigns(:user).remember_token
  end

  test "login without remembering" do
    log_in_as(@user, remember_me: '0')
    assert_nil cookies['remember_token']
  end

end
