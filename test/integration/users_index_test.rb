require 'test_helper'

class UsersIndexTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
  end

  test "index including pagination" do
    # log in
    log_in_as(@user)
    # go to users index
    get users_path
    # make sure it loade properly
    assert_template 'users/index'
    # check for div with pagination class
    assert_select 'div.pagination'
    # test first page is present
    User.paginate(page: 1).each do |user|
      # check for link to user page and for each user's name
      assert_select 'a[href=?]', user_path(user), text: user.name
    end
  end

end
