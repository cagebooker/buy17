class Admin::ItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_store, only: [:index, :create]
	layout 'backend'
  def index 
    @items = @store.items.all
  end
  def create 
    if @store.items.create item_params
        redirect_to admin_store_items_path(@store), notice: 'Item was successfully created.'
    else
        render 'stores/show'
    end
  end
  private
  def item_params
    params.require(:item).permit(:name, :price)
  end
  def set_store
    @store = Store.find(params[:store_id])
  end
end
