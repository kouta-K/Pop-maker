require 'test_helper'

class StoresControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
    @store = stores(:store1)
    @store2 = stores(:store3)
  end
  
  test "should be redirect_to current_user when registration is successful" do
    log_in(@user)
    get new_store_path
    assert_template "stores/new"
    post stores_path, params: {store: {name: "コーラ", price: 120, maker: "ペプシ", category: "食品", jan: "4901870300015"}}
    assert_redirected_to new_store_path
    assert flash[:success]
    follow_redirect!
    assert_template "stores/new"
  end
  
  test "should be redirect_to root url when no login" do
    post stores_path, params: {store: {name: "コーラ", price: 120, maker: "ペプシ", category: "食品", jan: "4901870300015"}}
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
  
  test "should be redirect_to root url when other user delete store" do
    log_in(@user)
    assert_no_difference "Store.count" do
      delete store_path(@store2)
    end
    assert_equal "権限がありません", flash[:danger]
    assert_redirected_to root_url
  end
  
  test "should be redirect_to stores index when edit successful" do
    log_in(@user)
    patch store_path(@store), params: {store: {name: "ポテチ", price: 120, maker: "湖池屋", category: "食品", jan: "4901870300015"}}
    assert_equal "編集しました", flash[:success]
    assert_redirected_to stores_url
    follow_redirect!
    @store.reload
    assert_equal "ポテチ", @store.name
    assert_template "stores/index"
  end
  
  test "shoud be reder stores#index when other user edit store " do
    log_in(@user)
    patch store_path(@store2), params: {store: {name: "ポテチ", price: 120, maker: "湖池屋", category: "食品", jan: "4901870300015"}}
    assert_equal "権限がありません", flash[:danger]
    assert_redirected_to root_url
  end
  
  test "can not edit store when not login" do
    patch store_path(@store), params: {store: {name: "ポテチ", price: 120, maker: "湖池屋", category: "食品"}}
    assert flash[:danger]
    assert_redirected_to root_url
  end
  
  test "render stores/new when invalid jan" do
    log_in(@user)
    assert_no_difference "Store.count" do
      post stores_path, params: {store: {name: "コーラ", price: 120, maker: "ペプシ", category: "食品", jan: "11"}}
    end
    assert flash[:danger]
    assert_template "stores/new"
  end
  
  test "should not print other registration store" do
    log_in(@user)
    get stores_path
    assert_template "stores/index"
    assert_match "ポテトチップス", response.body
    assert_no_match "ビスケット", response.body
  end
end
