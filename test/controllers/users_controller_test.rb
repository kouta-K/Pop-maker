require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  def setup 
    @user = users(:michael)
  end 
  test "should be count up user when signup" do
    get root_path
    assert_template "toppages/index"
    assert_difference "User.count" do
      post users_path, params: {user: {name: "test", email: "test3@co.jp", password: "password", password_confirmation: "password"}}
    end
    assert_not session[:user_id].nil?
    assert_redirected_to root_url
    assert flash[:success]
  end
  
  test "should be no count up user when failed signup" do
    get root_path
    assert_template "toppages/index"
    assert_no_difference "User.count" do
      post users_path, params: {user: {name: "test", email: "test1@co.jp", password: "password", password_confirmation: "password"}}
    end
    assert flash[:danger]
  end
  
  
  test "should be redirect_to root when login" do
    log_in(@user)
    assert_redirected_to root_url
    follow_redirect!
    assert_template "toppages/index"
  end
  
  
end
