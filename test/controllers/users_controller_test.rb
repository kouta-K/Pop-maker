require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  def setup 
    @user = users(:michael)
  end 
  test "should be count up user when signup" do
    get root_path
    assert_template "toppages/index"
    assert_difference "User.count" do
      post users_path, params: {user: {name: "test", email: "test2@co.jp", password: "password", password_confirmation: "password"}}
    end
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
  
  test "should be redirect_to root when no login" do
    get user_path(@user.id)
    assert_redirected_to root_url
  end
  
  test "should be redirect_to users/show when login" do
    log_in(@user)
    get user_path(@user)
    assert_template "users/show"
  end
  
  
end
