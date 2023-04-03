class OrdersController < ApplicationController
    before_action :set_purchase, only: [:create, :update]
    before_action :set_order, only: [:show, :edit, :update, :destroy, :total_price, :index]
    def index

    end
    def update
        if @order.update orders_params
            redirect_to purchase_path(@purchase)
        else
            render 'purchase/show'
        end
    end
    def create
        @order = @purchase.orders.new orders_params
        @order.user_id = current_user.id
        if @order.save
            redirect_to purchase_path(@purchase)
        else
            render json: { 'adb': @order.errors.full_messages, 'userid': current_user.id}
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
