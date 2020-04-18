require 'test_helper'

class StoresControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
    @store = stores(:store1)
  end
  
  test "should be redirect_to current_user when registration is successful" do
    log_in(@user)
    get new_store_path
    assert_template "stores/new"
    post stores_path, params: {store: {name: "コーラ", price: 120, maker: "ペプシ", category: "食品"}}
    assert_redirected_to @user
    assert flash[:success]
    follow_redirect!
    assert_template "users/show"
  end
  
  test "should be redirect_to root url when no login" do
    post stores_path, params: {store: {name: "コーラ", price: 120, maker: "ペプシ", category: "食品"}}
    assert_redirected_to root_url
    assert flash[:danger]
    follow_redirect!
    assert_template "toppages/index"
  end
  
  test "should be redirect_to stores/index when delete store data" do
    log_in(@user)
    assert_difference "Store.count", -1 do
      delete store_path(@store)
    end
    assert_redirected_to stores_url
  end
  
  test "should delet relational week data when delete store data" do
    log_in(@user)
    assert_difference "Week.count", -1 do
      delete store_path(@store)
    end
  end
  
  test "shoud be redirect_to root url when not login" do
    assert_no_difference "Store.count" do
      delete store_path(@store)
    end
    assert_redirected_to root_url
  end
  
  
  test "should be redirect_to stores index when edit successful" do
    log_in(@user)
    patch store_path(@store), params: {store: {name: "ポテチ", price: 120, maker: "湖池屋", category: "食品"}}
    assert_redirected_to stores_url
    follow_redirect!
    @store.reload
    assert_equal "ポテチ", @store.name
    assert_template "stores/index"
  end
  
  test "con not edit store when not login" do
    patch store_path(@store), params: {store: {name: "ポテチ", price: 120, maker: "湖池屋", category: "食品"}}
    assert flash[:danger]
    assert_redirected_to root_url
  end
end
