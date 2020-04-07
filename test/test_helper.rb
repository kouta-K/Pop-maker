ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'
include ApplicationHelper


class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  def log_in(user)
    session[:user_id] =user.id
  end
end

class ActionDispatch::IntegrationTest
  def log_in(user)
    post login_path, params: {session: {email: user.email, password: "password"}}
  end
end
