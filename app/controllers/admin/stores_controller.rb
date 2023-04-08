class Admin::StoresController < ApplicationController
  before_action :authenticate_user!
  before_action :set_store, only: [:edit, :update]
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
        redirect_to admin_stores_path, :notice => 'Store was successfully created.'
    else
        render 'new'
    end
  end
  def edit

  end
  def update
    @store.update store_params
    render 'edit'
    # redirect_to admin_stores_path, :notice => 'Store was successfully updated.'
  end
  def online
    @store = Store.find(params[:store_id])
    @store.up!
    redirect_to admin_stores_path, :notice => '店家已經上架'
  end
  def offline
    @store = Store.find(params[:store_id])
    @store.down!
    redirect_to admin_stores_path, :notice  => '店家已經下架'
  end
  def purchases
    @stores = current_user.stores
  end
  private
  def set_store
    @store = Store.find params[:id]
  end
  def store_params
    params.require(:store).permit(:name, :address, :phone, :description)
  end
end
