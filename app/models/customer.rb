class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :orders, dependent: :destroy
  has_many :addresses, dependent: :destroy
  has_many :cart_items, dependent: :destroy




  validates :last_name_kana,  format: {with: /\p{katakana}/ }, presence: true
  validates :first_name_kana, format: {with: /\p{katakana}/ }, presence: true
  validates :postal_code, format: { with: /\A\d{7}\z/ }, presence: true
  validates :telephone_number, format: { with: /\A\d{10,11}\z/ }, presence: true
  validates :email, presence: true, uniqueness: true
  validates :postal_code, presence: true
  validates :address, presence: true


end
