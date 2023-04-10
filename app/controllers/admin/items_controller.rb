class Admin::ItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_store, only: [:index, :create,:destroy]
  before_action :set_item, only: [:destroy]
	layout 'backend'
  def index 
    @items = @store.items.all
  end
  def create 
    if @store.items.create item_params
        redirect_to admin_store_items_path(@store), notice: '商品新增成功！'
    else
        render 'stores/show'
    end
  end
  def destroy
    # render json: @item
    @item.destroy
    redirect_to admin_store_items_path(@store), notice: '商品已經刪除！'
  end
  private
  def item_params
    params.require(:item).permit(:name, :price, :logo)
  end
  def set_store
    @store = Store.find(params[:store_id])
  end
  def set_item
    @item = Item.find(params[:id])
  end
end
