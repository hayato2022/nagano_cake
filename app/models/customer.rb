class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :orders, dependent: :destroy
  has_many :addresses, dependent: :destroy



  validates :last_name_kana, format: {with: /\p{katakana}/ }
  validates :first_name_kana, format: {with: /\p{katakana}/ }
  validates :postal_code, format: { with: /\A\d{7}\z/ }
  validates :telephone_number, format: { with: /\A\d{10,11}\z/ }

end
