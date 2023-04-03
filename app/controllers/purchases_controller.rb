class PurchasesController < ApplicationController
    before_action :set_group, only: [:done]
    def index 
        @purchases = Purchase.all
    end
    def new
        @group = Group.find params[:group_id]
        @purchase = Purchase.new
    end
    def show
        @purchase = Purchase.find params[:id]
        @order = Order.find_by(user: current_user, purchase: @purchase) || Order.new 
    end
    def create
        @purchase = current_user.purchases.build purchase_params
        @purchase.group_id = params[:group_id]
        if @purchase.save
            redirect_to purchases_path
        else
            render json: {'123':@purchase.errors.full_messages}
        end
    end
    def done 
        @purchases = @group.purchases.where("end_time < ?", Time.now)
    end
    def finished
        @purchase = Purchase.find(params[:purchase_id])
        @purchase.finish!
        redirect_to admin_stores_path
    end
    private
    def purchase_params
        params.require(:purchase).permit(:time_period, :store_id, :end_time)
    end
    def set_group  
        @group = Group.find params[:id]
    end
end
