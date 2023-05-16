class ItemsController < ApplicationController
    before_action :set_store, only: [:create, :edit, :update, ]
    before_action :set_item, only: [:edit, :update, :destroy]
    def index
        @store = Store.find(params[:store_id]).include(:items)
    end
    def create 
        if @store.items.create item_params
            redirect_to store_path(@store), notice: 'Item was successfully created.'
        else
            render 'stores/show'
        end
    end
    def edit

    end
    def update 
        if @item.update item_params
            redirect_to store_path(@store), notice: '新增商品成功！'
        else
            render 'edit'
        end
    end
    def destroy
        @group = Group.find(params[:store_id])
        render json: @item
        @item.destroy
        redirect_to store_path(@store), notice: '商品已刪除！'
    end

    private
    def set_store
        @store = Store.find(params[:store_id])
    end
    def item_params
        params.require(:item).permit(:name, :price)
    end
    def set_item
        @item = Item.find(params[:id])
    end
end
