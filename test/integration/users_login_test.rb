require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest

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

end
