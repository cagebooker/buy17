class OrdersController < ApplicationController
    before_action :set_purchase
    before_action :set_order, only: [:show, :edit, :update, :destroy, :total_price]
    def update
        if @order.update orders_params
            redirect_to purchase_path(@purchase)
        else
            render 'purchase/show'
        end
    end
    
    private
    def set_order
        @order = Order.find params[:id]
    end
    def set_purchase
        @purchase = Purchase.find(params[:purchase_id])
    end
    def orders_params
        params.require(:order).permit(
            ordered_items_attributes: [:id, :item_id, :quantity, :_destroy]
        )
    end
end
