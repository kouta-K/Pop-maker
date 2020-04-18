require 'rails_helper'

RSpec.describe "Weeks", type: :request do
  describe "GET #new(ajax)" do
    it "return json from #week_ajax" do
      post login_path, params: {session: {email: "test1@co.jp", password: "password"}}
      expect(session[:user_id]).not_to be_nil 
      get new_week_path, params: {week: "火曜"}, xhr: true
      expect(response.body).to match("cola")
    end
  end
end
