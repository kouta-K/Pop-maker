class ApplicationController < ActionController::Base
  include SessionsHelper
  
  def require_login 
    unless login?
      flash[:danger] = "ログインしてください"
      redirect_to root_url
    end
  end
end
