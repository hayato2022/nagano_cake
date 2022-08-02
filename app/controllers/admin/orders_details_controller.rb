class Admin::OrdersDetailsController < ApplicationController

  def update
    order_detail = OrdersDetail.find(params[:id])
    if order_detail.update(orders_detail_params)
      count = 0 #初期値
      order_detail.order.orders_details.each do |order_detail|
        if order_detail.making_status == "production_completed"#制作ステータスのステータスが製作完了に更新されたら、countに1にその数を追加する
          count += 1
        else
          break
        end
      end
      if order_detail.making_status == "production" #order_detail.making_statusが製作中だったらorder_detail.order.statusを製作中にする
         order_detail.order.status = "production"
      else
        count = order_detail.order.orders_details.count #countがorder_detail.order.order_details.count(商品の数)と同じだったら
        order_detail.order.status = "shipping_preparation" #発送準備にする
      end
      order_detail.order.save
      flash[:notice] = '更新されました。'
      redirect_to admin_order_path(order_detail.order_id)
    else
      @order = order_detail.order
      @order_details = @order.order_details
      render "orders/show"
    end
  end


  private

  def orders_detail_params
    params.require(:orders_detail).permit(:making_status)
  end

end
