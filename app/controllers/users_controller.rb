class UsersController < ApplicationController
  before_action :require_login, only: [:show]
  def show 
    @user = User.find(params[:id])
  end
  
  def create 
    @user = User.new(user_params)
    if @user.save 
      redirect_to @user
      flash[:success] = "作成しました"
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
