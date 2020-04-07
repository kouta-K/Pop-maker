require "test_helper"

class SessionsHelperTest < ActionView::TestCase
  def setup 
    @user = users(:michael)
  end 
  
  test "should be return current_user" do
    assert_nil current_user
    log_in(@user)
    assert_equal @user, current_user
  end
end