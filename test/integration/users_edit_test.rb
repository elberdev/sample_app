require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest

  # set up test user from our fixture
  def setup
    @user = users(:michael)
  end

  test "unsuccessful edit" do
    # load user account settings page
    get edit_user_path(@user)
    # verify that it loaded properly
    assert_template 'users/edit'
    # attempt to update the attributes with invalid parameters
    patch user_path(@user), user: { name: "",
                                    email: "foo@invalid",
                                    password: "foo",
                                    password_confirmation: "bar" }
    # check that the account settings page is loaded again as a result of
    # inputting invalid info
    assert_template 'users/edit'
  end

end
