class StoresController < ApplicationController
  before_action :require_login
  def index 
    @stores = Store.all
  end 
  def new
    @store = Store.new
  end
  
  def update
    @store = Store.find(params[:id])
    if @store.update_attributes(store_params)
      flash[:success] = "編集しました"
      redirect_to stores_url
    else 
      flash[:danger] = "編集に失敗にしました"
      render "stores/index"
    end
    
  end
  
  def create
    @store = Store.new(store_params)
    if @store.save 
      flash[:success] = "登録完了"
      redirect_to current_user
    else
      flash.now[:danger] = "登録失敗"
      render "stores/new"
    end
  end
  
  def destroy
    @store = Store.find(params[:id])
    if @store.destroy
      flash[:success] = "削除しました"
      redirect_to stores_url
    else 
    end
    
  end
  
  def store_params
    params.require(:store).permit(:name, :price, :maker, :category)
  end
end
