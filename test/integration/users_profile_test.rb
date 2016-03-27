require 'test_helper'

class UsersProfileTest < ActionDispatch::IntegrationTest
  include ApplicationHelper

  def setup
    @user = users(:michael)
  end

  test "profile display" do
    get user_path(@user)
    assert_template 'users/show'
    # the full_title() method comes from application_helper.rb
    assert_select 'title', full_title(@user.name)
    assert_select 'h1', text: @user.name
    # this is the nesting syntax for tags. It's looking for an img tag inside
    # an h1 block
    assert_select 'h1>img.gravatar'
    # response.body contains the full html of the page.
    # assert_select requires an accompanying html tag.
    # assert_match is does not.
    assert_match @user.microposts.count.to_s, response.body
    assert_select 'div.pagination'
    @user.microposts.paginate(page: 1).each do |micropost|
      assert_match micropost.content, response.body
    end
  end

end
