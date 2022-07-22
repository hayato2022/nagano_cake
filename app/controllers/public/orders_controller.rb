class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!

  def new
    @order = Order.new
    @customer = current_customer
  end

  def confirm
    @cart_items = current_customer.cart_items.all

    # 小計
    @total = @cart_items.inject(0){|sum, item| sum + item.subtotal }

    @postage = 800 #送料
     # 請求合計額
    @amount_billed = @cart_items.inject(0){|sum, item| sum + item.subtotal } + @postage


    @order = Order.new(order_params)



     # 選択された住所が自身の住所の場合。ラジオボタンの:select_addressが0
    if params[:order][:select_address] == '0'
      # ログインしている会員の郵便番号、住所、名前を取得
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.last_name + current_customer.first_name

    # 選択された住所が「登録済み住所から選択」の場合。ラジオボタンの:select_addressが1
    elsif params[:order][:select_address] == '1'
      # 送られた情報をもとに配送先モデルから検索。配送先(Address)モデルから送られてきた ID をもとに取得
      @address = Address.find(params[:order][:address_id])
      # @order の中に配送先(Address)モデルから取得した情報を格納
      @order.postal_code = @address.postal_code
      @order.address = @address.address
      @order.name = @address.name

      # 選択された住所が新しいお届け先の場合。ラジオボタン:select_addressの値が２
    elsif params[:order][:select_address] == '2'
      @order.postal_code = @order.postal_code
      @order.address = @order.address
      @order.name = @order.name

    else
      render :new
    end

  end

  def complete
  end

  def create
    @order = Order.new(order_params)
    cart_items = current_customer.cart_items.all

    # 取得したorder(注文)のcustomer_idカラムにログインしている会員のidを入れる
    @order.customer_id = current_customer.id
    if @order.save
      # 取り出したカートアイテムの数繰り返す
      cart_items.each do |cart_item|
        # OrdersDetaiモデルに保存するための空の箱
        orders_details = OrdersDetail.new
        # OrdersDetaiのitem_idカラムにカートに入れた商品のidを入れる
        orders_details.item_id = cart_item.item_id
        # OrdersDetaiのorder_idカラムに取得した注文idをいれる
        orders_details.order_id = @order.id
        #  OrdersDetaiのamountカラムにカートに入れた商品の数をいれる
        orders_details.amount = cart_item.amount
        # OrdersDetaiのpriceカラムにカートに入れた商品の価格のデータを入れる
        orders_details.price = cart_item.item.add_tax_price
        # カート情報を削除するので item との紐付けが切れる前に保存
        orders_details.save
      end
      redirect_to orders_complete_path
      # カート内商品を削除
      cart_items.destroy_all
    else

      redirect_to new_order_path
    end

  end

  def index
    @orders = Order.all
  end

  def show
    @order = Order.find(params[:id])
    # 特定の注文id(@order)に関連付けれた、商品の情報をすべて取得し、@orders_detailsに渡す
    # したがって、注文IDの商品の情報の数だけ、複数存在
    @orders_details = @order.orders_details
    @total = 0
  end

  private

  def order_params
    params.require(:order).permit(:payment_method, :postal_code, :address, :name, :postage, :amount_billed)
  end

end
