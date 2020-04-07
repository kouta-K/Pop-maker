require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  def setup 
    @user = users(:michael)
  end
  
  test "should be return users/show when login success" do
    get root_path
    assert_template "toppages/index" 
    post login_path, params: {session: {email: @user.email, password: "password"}}
    assert_redirected_to @user
    follow_redirect!
    assert_template "users/show"
    assert flash[:success]
    assert_select "a[href=?]", logout_path
  end
  
  test "should be render toppages/index when login failed with password difference" do
    get root_path 
    assert_template "toppages/index"
    post login_path, params: {session: {email: @user.email, password: "password1"}}
    assert_template "toppages/index"
    assert flash[:danger]
  end
  
  test "should be return root_url when logout success" do
    get root_path
    log_in(@user)
    follow_redirect!
    assert_template "users/show"
    delete logout_path
    assert_redirected_to root_url
    follow_redirect!
    assert flash[:success]
    assert_select "a[id=?]", "login"
    assert_select "a[id=?]", "signup"
  end
  
  test "should be return root_url when logout failed" do
    get root_path
    delete logout_path
    assert_redirected_to root_url
    follow_redirect!
    assert flash[:danger]
    
  end
end
