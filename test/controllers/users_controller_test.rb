require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should be return show when signup" do
    get root_path
    assert_template "toppages/index"
    assert_difference "User.count" do
      post users_path, params: {user: {name: "test", email: "test2@co.jp", password: "password", password_confirmation: "password"}}
    end
  end
end
