require 'rails_helper'

RSpec.describe User, type: :model do
  it "is invalid same email" do
    User.create(name: "test1", email: "test@co.jp", password: "password", password_confirmation: "password")
    same_user = User.new(name: "test2", email: "test@co.jp", password: "password", password_confirmation: "password")
    expect(same_user).to_not be_valid
  end
end
