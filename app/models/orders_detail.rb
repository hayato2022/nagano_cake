class OrdersDetail < ApplicationRecord

  belongs_to :order
  belongs_to :item

  # 消費税を加えた商品価格
  def add_tax_price
    (self.price * 1.10).round
  end

  def subtotal
    price * amount
  end

  def amount_total
    amount + amount
  end

end
