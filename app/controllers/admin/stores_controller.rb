class Admin::StoresController < ApplicationController
  before_action :authenticate_user!
  before_action :set_store, only: [:edit, :update]
	layout 'backend'

  def index
    @stores = current_user.stores.includes(:purchases)
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
  private
  def set_store
    @store = Store.find params[:id]
  end
  def store_params
    params.require(:store).permit(:name, :address, :phone, :description)
  end
end
