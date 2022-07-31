class Admin::OrdersController < ApplicationController

  def show
    @orders = Order.all
    @order = Order.find(params[:id])
    @orders_detail = OrdersDetail.find(params[:id])
    @orders_details = @order.orders_details
    @customer = @order.customer
    @total = 0
    @postage = 800
    @amount_billed = 0
  end

  def update
    @order = Order.find(params[:id])
    @order.update(order_params)
    redirect_to admin_order_path(@order.id)
  end

  private

  def order_params
    params.require(:order).permit(:status)
  end

end
