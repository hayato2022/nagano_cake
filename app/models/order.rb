class Order < ApplicationRecord

    belongs_to :customer

    enum status: {awaiting_payment: 0, payment_confirmation: 1, production: 2, shipping_preparation: 3, shipped: 4}
end
