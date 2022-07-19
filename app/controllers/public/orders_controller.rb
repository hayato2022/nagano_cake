class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!

  def new
    @order = Order.new
    @customer = current_customer
  end

  def confirm
    @cart_items = current_customer.cart_items.all
    @postage = 800 #送料
    @total =0
    @amount_billed = 0

    @order = Order.new(order_params)
    # 選択された住所が自身の住所の場合。ラジオボタンの:select_addressが0
    if params[:order][:payment_method] == "credit_card"
      @payment_method = "クレジットカード"
    elsif params[:order][:payment_method] == "transfer"
      @payment_method = "銀行振込"
    end

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
  end

  def index
  end

  def show
  end

  private

  def order_params
    params.require(:order).permit(:payment_method, :postal_code, :address, :name)
  end

end
