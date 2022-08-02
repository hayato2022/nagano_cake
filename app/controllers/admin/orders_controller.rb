class Admin::OrdersController < ApplicationController

  def show
    @order = Order.find(params[:id])

    @orders_details = @order.orders_details
    @customer = @order.customer
    @total = 0
    @postage = 800
    @amount_billed = 0
  end

  def update
    @order = Order.find(params[:id])
    @order.update(order_params)
    # 注文ステータスと制作ステータスの更新の連動
    @orders_details = @order.orders_details
    if @order.status == "payment_confirmation"
      @orders_details.each do |orders_detail|
        orders_detail.making_status = "awaiting_production"
        orders_detail.save
      end
    end
    redirect_to admin_order_path(@order.id)
  end

  private

  def order_params
    params.require(:order).permit(:status)
  end

end
