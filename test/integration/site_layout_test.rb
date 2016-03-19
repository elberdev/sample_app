require 'test_helper'

# this test class helps us validate all the links in the home page

class SiteLayoutTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
  end

  def assert_common_links
    assert_select "a[href=?]", root_path, count: 2
    assert_select "a[href=?]", help_path
    assert_select "a[href=?]", about_path
    assert_select "a[href=?]", contact_path
  end

  test "layout links" do

    # before login

    # get the root path
    get root_path
    # verify that the correct page is loaded
    assert_template 'static_pages/home'
    # test all the links with method assert_select
    assert_common_links
    assert_select "a[href=?]", signup_path
    assert_select "a[href=?]", login_path
    # get signup path
    get signup_path
    # check title of signup page
    assert_select "title", full_title("Sign up")

    # after login

    log_in_as(@user)
    get root_path
    assert_common_links
    assert_select "a[href=?]", users_path
    assert_select "a[href=?]", user_path(@user)
    assert_select "a[href=?]", edit_user_path(@user)
    assert_select "a[href=?]", logout_path
  end
end
