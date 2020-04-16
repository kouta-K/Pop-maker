class ApplicationController < ActionController::Base
  include SessionsHelper
  def require_login 
    if current_user.nil?
      flash[:danger] ="ログインしてください"
      redirect_to root_url
    end
  end
end
