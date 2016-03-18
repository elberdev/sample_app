require 'test_helper'

class UsersIndexTest < ActionDispatch::IntegrationTest

  def setup
    @admin = users(:michael)
    @non_admin = users(:archer)
  end

  test "index as admin including pagination and delete links" do
    # log in
    log_in_as(@admin)
    # go to users index
    get users_path
    # make sure it loade properly
    assert_template 'users/index'
    # check for div with pagination class
    assert_select 'div.pagination'
    first_page_of_users = User.paginate(page: 1)
    # test first page is present
    first_page_of_users.each do |user|
      # check for link to user page and for each user's name
      assert_select 'a[href=?]', user_path(user), text: user.name
      # check for delete link
      unless user == @admin
        assert_select 'a[href=?]', user_path(user), text: 'delete'
      end
    end
    # check for proper deletion
    assert_difference 'User.count', -1 do
      delete user_path(@non_admin)
    end
  end

  test "index as non-admin" do
    log_in_as(@non_admin)
    get users_path
    # make sure there are no delete links
    assert_select 'a', text: 'delete', count: 0
  end

end
