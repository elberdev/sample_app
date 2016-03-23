require 'test_helper'

class MicropostTest < ActiveSupport::TestCase

  def setup
    @user = users(:michael)
    # This code is not idiomatically correct, because of the belongs_to and
    # has_many realtionships between a user and his microposts. The correct
    # way is the uncommented version
    #@micropost = Micropost.new(content: "Lorem ipsum", user_id: @user.id)
    @micropost = @user.microposts.build(content: "Lorem ipsum")
  end

  test "should be valid" do
    assert @micropost.valid?
  end

  test "user id should be present" do
    @micropost.user_id = nil
    assert_not @micropost.valid?
  end

  test "content should be present" do
    @micropost.content = "     "
    assert_not @micropost.valid?
  end

  test "content should be at most 140 characters" do
    @micropost.content = "a" * 141
    assert_not @micropost.valid?
  end

  # make sure the first micropost displayed is the most recent.
  # Micropost.first calls the first of the micropost fixtures. See microposts.yml
  test "order should be more recent first" do
    assert_equal microposts(:most_recent), Micropost.first
  end

end
