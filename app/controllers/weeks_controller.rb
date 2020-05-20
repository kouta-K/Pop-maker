class WeeksController < ApplicationController
  before_action :require_login
  before_action :exit_params, only: [:create]
  before_action :correct_id, only: [:create]
  before_action :correct_week, only: [:create]
  before_action :correct_user, only: [:destroy]

  def index 
    @storeMon = which_week("月曜")
    @storeTue = which_week("火曜")
    @storeWen = which_week("水曜")
    @storeThu = which_week("木曜")
    @storeFri = which_week("金曜")
    @storeSat = which_week("土曜")
    @storeSun = which_week("日曜")
  end 
  
  def new
    week = params[:week] || "月曜"
    exclude_week(week)
    @week = Week.new
    respond_to do |format|
      format.html
      format.json                        
    end
  end
  
  def create
    @store_ids.each do |id|
      week = Week.new(week: params[:week][:week], store_id: id)
      week.save
    end
    flash[:success] = "登録しました"
    redirect_to weeks_url
  end
  
  def destroy
    week_name = @week.week
    store_name = @week.store.name
    if @week.destroy
      flash[:success] = "#{week_name}から#{store_name}を削除しました"
      redirect_to weeks_path
    else 
      flash[:danger] = "削除に失敗しました"
      redirect_to weeks_path
    end 
  end 
  
  
  def pdf 
    @stores = which_week(params[:week])
    @jans = jan_codes(@stores)
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "sample",   # PDF名
               template: "weeks/pdf.html.erb",
               encoding: "UTF-8",
               page_size: "A4"
      end
    end
  end 
  
  private 
    def correct_user
       @week = Week.find(params[:id])
       if current_user.id != @week.store.user.id
         flash[:danger]  = "権限がありません"
         redirect_to root_url
       end 
    end 
    
    def exit_params 
      @store_ids = params[:week][:store]
      if @store_ids.nil?
        flash[:danger] = "商品が選択されていません"
        redirect_to weeks_url
      end
    end
    
    def correct_week
      weeks = ['月曜', '火曜', '水曜', '木曜', '金曜', '土曜', '日曜']
      unless weeks.include?(params[:week][:week])
        flash[:danger] = '不正な曜日が含まれています'
        redirect_to root_url
      end 
    end 
    
    def correct_id 
      @store_ids.each do |id| 
        unless Store.find_by(id: id) 
          flash[:danger] = "無効な値が含まれています"
          redirect_to weeks_url
        end 
      end 
    end 
    
    def which_week(week)
      stores= []
      weeks = Week.where(week: week)
      weeks.each do |week| 
        stores.append(week.store)
      end 
      return stores
    end 
    
    def exclude_week(week)
      store = which_week(week)#与えられた曜日に登録された商品
      @stores = Store.all - store
    end
    
    def jan_codes(stores)
      jans = []
      stores.each do |store|
        jans.append(store.jan)
      end 
      return jans
    end
end
