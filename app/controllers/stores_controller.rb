class StoresController < ApplicationController
    before_action :set_store, only: [:show, :edit, :destroy ,:update]
    before_action :set_group, only: [:index, :show, :edit, :destroy ,:update, :set]
    before_action :set_store_by_id, only: [:set]
    def total
        @allStores = Store.where.not(state: 'offline').includes(:items)
    end
    def index 
        @stores = @group.stores.includes(:items)
    end
    def set
        # 建立 group store的關聯
        @group.stores << @store
        redirect_to '/stores'
    end
    def new
        @store = Store.new
    end
    def create 
        @store = Store.new store_params
        if @store.save
            redirect_to stores_path, :notice => 'Store was successfully created.'
        else
            render 'new'
        end
    end
    def show   
    end
    def edit

    end
    def update
        @store.update store_params
        redirect_to stores_path, :notice => 'Store was successfully updated.'
    end
    def destroy
        @store.destroy
        redirect_to stores_path, :notice => 'Store was successfully destroyed.'
    end
    private
    def set_group 
        @group = Group.find(params[:group_id])
    end
    def set_store 
        @store = Store.find(params[:id])
    end
    def store_params
        params.require(:store).permit(:name, :address, :phone, :description)
    end
    def set_store_by_id
        @store = Store.find(params[:store_id])
    end
end
