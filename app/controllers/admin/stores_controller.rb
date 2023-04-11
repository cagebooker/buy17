class Admin::StoresController < ApplicationController
  before_action :authenticate_user!
  before_action :set_store, only: [:edit, :update]
  before_action :set_store_2, only: [:online, :offline, :pending]
	layout 'backend'

  def index
    @stores = current_user.stores.includes(:purchases)
    # 把擁有的店家id作成[]，準備去比對 purchase
    store_id_set = []
    @stores.each do |store|
      store_id_set << store.id
    end
    # render json: {'123':store_id_set}
    # 感覺這種寫法效能很差...
    @purchases_pending = Purchase.where("end_time < ?",Time.now).where(state: 'pending', store_id: store_id_set)
    @purchases_done = Purchase.where(state: 'finished', store_id: store_id_set)

  end
  def new
    @store = Store.new
  end
  def create
    @store = current_user.stores.new store_params
    if @store.save
        redirect_to admin_stores_path, :notice => '成功建立新的店家.'
    else
        render 'new'
    end
  end
  def edit
    @items = @store.items
  end
  def update
    @store.update store_params
    render 'edit', :notice => '商店資訊已經更新！'
    # redirect_to admin_stores_path, :notice => 'Store was successfully updated.'
  end
  def online
    @store.up!
    redirect_to admin_stores_path, :notice => '店家已經上線囉！'
  end
  def offline
    @store.down!
    redirect_to admin_stores_path, :notice  => '店家已經關閉囉！'
  end
  def pending
    @store.prepare!
    redirect_to admin_stores_path, :notice  => '店家已經改為準備中！'
  end
  def purchases
    @stores = current_user.stores.includes(:purchases)
  end
  private
  def set_store_2
    @store = Store.find(params[:store_id])
  end
  def set_store
    @store = Store.find params[:id]
  end
  def store_params
    params.require(:store).permit(:name, :address, :phone, :description, :cover)
  end
end
