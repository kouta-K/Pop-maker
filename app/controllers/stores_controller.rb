class StoresController < ApplicationController
  before_action :require_login
  before_action :jan_correct, only: [:create, :update]
  before_action :correct_store, only: [:update]
  def index 
    @stores = current_user.stores
  end 
  
  def new
    @store = current_user.stores.build()
  end
  
  def update
    if @store.update_attributes(store_params)
      flash[:success] = "編集しました"
      redirect_to stores_url
    else 
      flash[:danger] = "編集に失敗しました"
      render "stores/index"
    end
    
  end
  
  def create
    @store = current_user.stores.build(store_params)
    if @store.save 
      flash[:success] = "登録完了"
      redirect_to new_store_path
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
  private
    def store_params
      params.require(:store).permit(:name, :price, :maker, :category, :jan)
    end
    
    def jan_correct 
      params_jan = params[:store][:jan]
      if params_jan.nil? || params_jan == ""
        flash[:danger] = "無効なJANコードです!"
        redirect_to new_store_path
      else
        jan = Jan::Code.new(params_jan)
        unless jan.valid?
          flash[:danger] = "無効なJANコードです"
          redirect_to new_store_path
        end 
      end
    end
    
    def correct_store 
      @store = Store.find(params[:id])
      unless @store.user_id == current_user.id
        flash[:danger] = "編集に失敗しました"
        redirect_to root_url
      end 
    end 
    
end
