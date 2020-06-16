require 'test_helper'

class StoreTest < ActiveSupport::TestCase
  def setup 
    @store = Store.new(name: "コーラ", price: 120, category: "飲料", maker: "ペプシ", jan: "4901870300015", user_id: 1)
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
  
  test "jan is invalid when jan is too shorter" do
    jan = Jan::Code.new("1234")
    assert_not jan.valid?
  end
  
  
  test "error is empty when import valid file" do
    file = StoreTest.upfile('test/csv_test_file/valid.csv')
    errors = Store.import(file, 1)
    assert errors.empty?
  end
  
  test "return error when jan is exist" do
    file = StoreTest.upfile('test/csv_test_file/exit_jan.csv')
    assert_no_difference "Store.count" do
      Store.import(file, 1)
    end
  end
  
  test "return error when price is not presence" do
    file = StoreTest.upfile("test/csv_test_file/no_price.csv")
    errors = Store.import(file, 1)
    assert errors[0][:error].include?("Name can't be blank")
  end
  
  test "return error when header is invalid" do
    file = StoreTest.upfile("test/csv_test_file/invalid_header.csv")
    assert_no_difference "Store.count" do
      Store.import(file, 1)
    end
  end
  
  test "should be return error when jan is invalid" do
    file = StoreTest.upfile("test/csv_test_file/invalid_jan.csv")
    errors = Store.import(file, 1)
    assert errors[0][:error].include?("無効なjanです")
  end
  
  #csvファイルをテストするための特異メソッド
  def self.upfile(path)
    file_path = File.join(Rails.root, path)
    ActionDispatch::Http::UploadedFile.new(
      filename: File.basename(file_path),
      type: 'text/csv',
      tempfile: File.open(file_path)
    )
  end 
end
