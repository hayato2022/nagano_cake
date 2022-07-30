class OrdersDetail < ApplicationRecord

  belongs_to :order
  belongs_to :item

  enum making_status: {not_start: 0, awaiting_production: 1, production: 2, production_completed: 3 }

  # 消費税を加えた商品価格
  def add_tax_price
    (self.price * 1.10).round
  end

  def subtotal
    price * amount
  end



end
