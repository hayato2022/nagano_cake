class Admin::OrdersDetailsController < ApplicationController

  def update
    @orders_detail=Ordersdetail.find(params[:id])
    @orders_detail.update(orders_detail_params)
    redirect_to admin_order_path(@order.id)
  end

  private

  def orders_detail_params
    params.require(:orders_detail).permit(:making_status)
  end

end
