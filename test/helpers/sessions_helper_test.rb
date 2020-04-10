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
  
  test "should be return true when login" do
    log_in(@user)
    assert login?
  end
  
  test "should be return false when no login" do
    assert_not login?
  end
end