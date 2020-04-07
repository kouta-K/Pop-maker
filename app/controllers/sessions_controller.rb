class SessionsController < ApplicationController
  def create 
    email  = params[:session][:email].downcase
    password = params[:session][:password]
    @user = User.find_by(email: email)
    if @user && @user.authenticate(password)
      session[:user_id] = @user.id
      flash[:success] ="ログイン"
      redirect_to @user
    else 
      flash.now[:danger] ="失敗"
      render "toppages/index"
    end
  end
  
  def destroy
    if session[:user_id].nil?
      flash[:danger] = "ログアウト失敗"
      redirect_to root_url
    else 
      session.delete(:user_id)
      flash[:success] = "ログアウトしました"
      @current_user = nil
      redirect_to root_url
    end
  end
end
