class Order < ApplicationRecord

    belongs_to :customer
    has_many :orders_details, dependent: :destroy

    enum status: {awaiting_payment: 0, payment_confirmation: 1, production: 2, shipping_preparation: 3, shipped: 4}

    enum payment_method: {credit_card: 0, transfer:1}



end
