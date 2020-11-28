class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :addresses, dependent: :destroy
  has_many :cart_items, dependent: :destroy
  has_many :orders, dependent: :destroy
  # has_many :orders, source: :order, foreign_key: 'customer_id', dependent: :destroy
  # has_many :order_details, through: :orders, source: :order_detail

  def active_for_authentication?
    super && (self.is_deleted == false)
  end
end
