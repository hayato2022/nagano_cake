class CartItem < ApplicationRecord

  belongs_to :item

# 小計を求めるメソッド
  def subtotal
      item.add_tax_price * amount
  end

end
