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

  test "successful edit" do
    get edit_usder_path(@user)
    assert_template 'users/edit'
    name = "Foo Bar"
    email = "foo@bar.com"
    patch user_path(@user), user: { name: name,
                                   email: email,
                                   password: "",
                                   password_confirmation: "" }
    # make sure flash message is not empty
    assert_not flash.empty?
    # make sure we are redirected to the user page
    assert_redirected_to @user
    # load user from the database again to check updates were saved
    @user.reload
    # make sure info is correct
    assert_equal name, @user.name
    assert_equal email, @user.email
  end

end
