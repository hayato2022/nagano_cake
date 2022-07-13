class Public::CartItemsController < ApplicationController
  before_action :authenticate_customer!

  def index
    @cart_items = current_costomer.cart_items.all
    # 合計金額
    @total = 0
  end

  def create
    @cart_item = current_customer.cart_items.new(cart_item_params)
     # もし元々カート内に「同じ商品」がある場合、「数量を追加」更新・保存する
      #例.プリン２個、プリン２個ではなく　プリン「4個」にしたい
    if current_costomer.cart_items.find_by(item_id: params[:cart_item][:item_id]).present?
       #元々カート内にあるものが「item_id」
       #今追加したもの　params[:cart_item][:item_id])
      cart_item = current_costomer.cart_items.find_by(item_id: params[:cart_item][:item_id])
      cart_item.amount += params[:cart_item][:amount].to_i
      #cart_item.amount(数量)に今追加したparams[:cart_item][:quantity]を加える
                                                  #.to_iにして数字として扱う
      cart_item.save
      redirect_to cart_items_path

     # もしカート内に「同じ」商品がない場合は通常の保存処理
    elsif @cart_item.save
      @cart_items =  current_costomer.cart_items.all
      render :index
    else　# 保存できなかった場合
      render :index
    end
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    redirect_to cart_items_path
  end

  def destroy_all
    @cart_items = current_costomer.cart_items.destroy_all
    redirect_to cart_items_path
  end

  private

  def cart_item_params
    params.requie(:cart_item).permit(:amount, :item_id, :price)
  end

end
