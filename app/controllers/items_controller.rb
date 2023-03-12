class ItemsController < ApplicationController
    before_action :set_store, only: [:create, :edit, :update, :destroy]
    before_action :set_item, only: [:edit, :update, :destroy]
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
            redirect_to store_path(@store), notice: 'Item was successfully updated.'
        else
            render 'edit'
        end
    end
    def destroy
        @item.destroy
        redirect_to store_path(@store), notice: 'Item was successfully destroyed.'
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
