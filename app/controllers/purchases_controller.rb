class PurchasesController < ApplicationController
    before_action :set_group, only: [:done]
    def index 
        # render json: params
        @group = Group.find(params[:group_id])
        @purchases = @group.purchases.where("end_time > ?", Time.now).includes(:orders)
        @purchases_unpaid = @group.purchases.where("end_time < ?", Time.now).where(state:'pending').includes(:orders)
    end
    def new
        @group = Group.find params[:group_id]
        @purchase = Purchase.new
    end
    def show
        @group = Group.find params[:group_id]
        @purchase = Purchase.find params[:id]
        @order = Order.find_by(user: current_user, purchase: @purchase) || Order.new 
    end
    def create
        # render json: {'kevin':'in create method'}
        @purchase = current_user.purchases.build purchase_params
        @purchase.group_id = params[:group_id]
        if @purchase.save
            redirect_to group_purchases_path
        else
            render json: {'123':@purchase.errors.full_messages}
        end
    end
    def destroy
        # render json: params
        @group = Group.find(params[:group_id])
        @purchase = Purchase.find(params[:id])
        if @purchase.destroy
            redirect_to group_purchases_path(@group), notice: '本次團購已經取消'
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
    def refunded
        @purchase = Purchase.find(params[:purchase_id])
        @purchase.refund!
        redirect_to admin_stores_path
    end
    def line_pay
        @group = Group.find(params[:group_id])
        @purchase = Purchase.find(params[:purchase_id])
        purchase_id = params[:purchase_id]
        if @purchase.num == nil
            @purchase.num = SecureRandom.hex(5)  
        end
       
        resp = Faraday.post("#{ENV['line_pay_endpoint']}/v2/payments/request") do |req|
            req.headers['Content-Type'] = 'application/json'
            req.headers['X-LINE-ChannelId'] = ENV['line_pay_channel_id']
            req.headers['X-LINE-ChannelSecret'] = ENV['line_pay_channel_secret']
            req.body = {
            productName: @purchase.store.name+"的訂單",
            amount: @purchase.total_income.to_i,
            currency: 'TWD',
            confirmUrl: "http://localhost:5000/purchase/#{purchase_id}/confirm",
            orderId: @purchase.num
            }.to_json
        end
        result = JSON.parse(resp.body)
        # render json: result

        if result["returnCode"] == "0000"
            payment_url = result["info"]["paymentUrl"]["web"]
            redirect_to payment_url
        else
            flash[:notice] = '付款發生錯誤'
            redirect_to group_purchases_path(@group)
        end
    end
    def confirm
        
        @purchase = Purchase.find(params[:id])
        resp = Faraday.post("#{ENV['line_pay_endpoint']}/v2/payments/#{params[:transactionId]}/confirm") do |req|
            req.headers['Content-Type'] = 'application/json'
            req.headers['X-LINE-ChannelId'] = ENV['line_pay_channel_id']
            req.headers['X-LINE-ChannelSecret'] = ENV['line_pay_channel_secret']
            req.body = {
                amount: @purchase.total_income.to_i,
                currency: 'TWD',
            }.to_json
        end
        result = JSON.parse(resp.body)
        # render json: result
        if result["returnCode"] == "0000"

            # render json: result
            purchase_id = result["info"]["orderId"]
            transaction_id = result["info"]["transactionId"]
            # 1.變更 order 狀態
            # @purchase = Purchase.find_by(num: purchase_id)
            # render json: @purchase
            @purchase.pay!

            # render json: result["returnCode"]
            redirect_to root_path, notice: '付款完成'
        else
            redirect_to root_path, notice: '確認付款發生錯誤'
        end
    end

    def details
        # render json: params
        @group = Group.find(params[:group_id])
        @purchase = Purchase.find(params[:id])
    end
    def history 
        @orders = current_user.orders.order(id: :desc).includes(:items,:ordered_items)
    end

    private
    def purchase_params
        params.require(:purchase).permit(:time_period, :store_id, :end_time)
    end
    def set_group  
        @group = Group.find params[:id]
    end
end
