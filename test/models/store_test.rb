require 'test_helper'

class StoreTest < ActiveSupport::TestCase
  def setup 
    @store = Store.new(name: "コーラ", price: 120, category: "飲料", maker: "ペプシ", jan: "4901870300015")
  end 
  
  test "should be precense name" do
    assert @store.valid?
    @store.name = ""
    assert_not @store.valid?
  end
  
  test "should be precense category" do
    assert @store.valid?
    @store.category = ""
    assert_not @store.valid?
  end
  
  test "should be precense price" do
    assert @store.valid?
    @store.price = nil
    assert_not @store.valid?
  end
  
  test "should be precense maker" do
    assert @store.valid?
    @store.maker = ""
    assert_not @store.valid?
  end
  
  test "should be price type is int" do
    assert @store.valid?
    @store.price = "test"
    assert_not @store.valid?
    @store.price = "123"
    assert_equal @store.price, 123
    assert_not_equal @store.price, "123"
  end
  
  test "it is invalid when jan is not uniqueness" do
    @store = Store.new(name: "サイダー", price: 120, category: "飲料", maker: "ペプシ", jan: "4902074010625")
    assert_not @store.valid?
  end
end
