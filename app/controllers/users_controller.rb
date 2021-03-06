class UsersController < ApplicationController
  def create 
    @user = User.new(user_params)
    if @user.save 
      session[:user_id] = @user.id
      flash[:success] = "作成しました"
      redirect_to root_url
    else 
      flash.now[:danger] = "作成失敗"
      render "toppages/index"
    end
  end
  
  private
    def user_params 
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
