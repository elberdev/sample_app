require 'test_helper'

class UsersControllerTest < ActionController::TestCase

  def setup
    @user       = users(:michael)
    @other_user = users(:archer)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should redirect edit when not logged in" do
    get :edit, id: @user
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect update when not logged in" do
    patch :update, id: @user, user: { name: @user.name, email: @user.email }
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect edit when logged in as wrong user" do
    # log in as wrong user
    log_in_as(@other_user)
    # try to edit someone else's user settings
    get :edit, id: @user
    assert flash.empty?
    # make sure we get redirected to the root url, instead of getting accessed
    # to another user's settings
    assert_redirected_to root_url
  end

  test "should redirect update when logged in as wrong user" do
    log_in_as(@other_user)
    patch :update, id: @user, user: { name: @user.name, email: @user.email }
    assert flash.empty?
    assert_redirected_to root_url
  end

  test "should not allow the admin attribute to be edited via the web" do
    log_in_as(@other_user)
    assert_not @other_user.admin?
    patch :update, id: @other_user, user: { name: @other_user.name,
                                            email: @other_user.email,
                                            password: "",
                                            password_confirmation: "",
                                            admin: true
                                          }
    assert_not @other_user.reload.admin?
  end

  # make sure that if user in not properly logged in, a call to the index
  # path redirects to login page
  test "should redirect index when not logged in" do
    get :index
    assert_redirected_to login_url
  end

  test "should redirect destroy when not logged in" do
    # try to delete a user and assert there is no difference in the user count
    assert_no_difference 'User.count' do
      delete :destroy, id: @user
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy when logged in as a non-admin" do
    # log in as non-admin user first
    log_in_as(@other_user)
    assert_no_difference 'User.count' do
      delete :destroy, id: @user
    end
    assert_redirected_to root_url
  end

  test "should redirect following when not logged in" do
    get :following, id: @user
    assert_redirected_to login_url
  end

  test "should redirect followers when not logged in" do
    get :followers, id: @user
    assert_redirected_to login_url
  end

end
