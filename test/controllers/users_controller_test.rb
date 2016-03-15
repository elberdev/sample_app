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

  test "should redirect edit when logges in as wrong user" do
    # log in as wrong user
    log_in_as @other_user
    # try to edit someone else's user settings
    get :edit, id: @user
    assert flash.empty?
    # make sure we get redirected to the root url, instead of getting accessed
    # to another user's settings
    assert_redirected_to root_url
  end

  test "should redirect update when logged in as wrong user" do
    log_in_as @other_user
    patch :update, id: @user, user: { name: @user.name, email: @user.email }
    assert flash.empty?
    assert_redirected_to root_url
  end

  # make sure that if user in not properly logged in, a call to the index
  # path redirects to login page
  test "should redirect index when not logged in" do
    get :index
    assert_redirected_to login_url
  end

end
