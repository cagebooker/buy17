class PurchasesController < ApplicationController
    def index 
        @purchases = Purchase.all
    end
    def new
        @purchase = Purchase.new
    end
    def show
        @purchase = Purchase.find params[:id]
        @order = Order.find_by(user: current_user, purchase: @purchase) || Order.new 
    end
    def create
        @purchase = current_user.purchases.build purchase_params
        
        if @purchase.save
            redirect_to purchases_path
        else
            render 'new'
        end
    end
    private
    def purchase_params
        params.require(:purchase).permit(:time_period, :store_id, :end_time)
    end
end
