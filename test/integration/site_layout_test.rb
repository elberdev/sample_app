require 'test_helper'

# this test class helps us validate all the links in the home page

class SiteLayoutTest < ActionDispatch::IntegrationTest
  test "layout links" do

    # get the root path
    get root_path

    # verify that the correct page is loaded
    assert_template 'static_pages/home'

    # test all the links with method assert_select
    # this first one has two links to test.
    assert_select "a[href=?]", root_path, count: 2
    assert_select "a[href=?]", help_path
    assert_select "a[href=?]", about_path
    assert_select "a[href=?]", contact_path
    assert_select "a[href=?]", signup_path

    # get signup path
    get signup_path

    # check title of signup page
    assert_select "title", full_title("Sign up")
  end
end
