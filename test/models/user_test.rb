require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: "Example User", email: "Test@co.jp",
                     password: "foobar", password_confirmation: "foobar")
  end
  
  test "should be invalid when name is not presence or too longer" do 
    assert @user.valid?
    @user.name = ""
    assert_not @user.valid?
    @user.name ="a"*31
    assert_not @user.valid?
  end
  
  test "should be invalid when email is not presence" do
    assert @user.valid?
    @user.email = ""
    assert_not @user.valid?
  end
  
  test "should be downcase email before user save"  do
    @user.save 
    assert_equal "test@co.jp", @user.email
  end
  
  test "should be invalid when email is not uniqueness" do
    @user.save 
    other_user = User.new(name: "Example User", email: "Test@co.jp",
                     password: "foobar", password_confirmation: "foobar")
    assert_not other_user.valid?
                     
  end
  
  test "should be invalid when password is not presence or too shorter" do
    @user.password = ""
    @user.password_confirmation=""
    assert_not @user.valid?
    @user.password = "a"*5
    @user.password_confirmation = "a"*5
    assert_not @user.valid?
  end
end
