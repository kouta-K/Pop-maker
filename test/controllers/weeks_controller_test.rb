require 'test_helper'

class WeeksControllerTest < ActionDispatch::IntegrationTest
  def setup 
    @user = users(:michael)
    @store1 = stores(:store1)
    @store2 = stores(:store2)
  end 
  
  
  test "should be redirect_to root url when week store registration is successful" do
    log_in(@user)
    assert_difference "Week.count", 1 do
      post weeks_path, params: {week: {store: [1], week: "月曜"}}
    end
    assert flash[:success]
    assert_redirected_to weeks_url
  end
  
  test "should be redirect_to weeks_url when invalid store id" do
    log_in(@user)
    assert_no_difference "Week.count" do
      post weeks_path, params: {week: {store: [10000], week: "月曜"}}
    end
    assert_redirected_to weeks_url
    assert flash[:danger]
  end
  
  test "should be redirect_to weeks_url when not choose checkbox" do
    log_in(@user)
    assert_no_difference "Week.count" do
      post weeks_path, params: {week: {store: [], week: "月曜"}}
    end
    assert_redirected_to weeks_url
    assert flash[:danger]
  end
  
  
  test "should be return monday store" do
    stores = which_week("月曜")
    assert stores.include?(@store1)
    assert_not stores.include?(@store2)
  end
  
  test "shoud be redirect_to root_url when invalid week" do
    log_in(@user)
    assert_no_difference "Week.count" do
      post weeks_path, params: {week: {store: [1], week: "こんにちは"}}
    end
    assert_redirected_to root_url
    assert flash[:danger]
  end
  
  test "should be return store when get ajax  " do
    log_in(@user)
    get new_week_path, params: {week: "火曜"}, xhr: true
    assert_match "cola", response.body
  end
  
  test "return weeks/pop when click pop" do
    log_in(@user)
    get pop_weeks_path
    assert_template "weeks/pop"
  end
 
end

