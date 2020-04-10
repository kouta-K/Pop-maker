class ApplicationController < ActionController::Base
  include SessionsHelper
  
  def require_login 
    unless login?
      redirect_to root_url
    end
  end
end
