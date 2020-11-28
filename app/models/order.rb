class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_details, dependent: :destroy
  enum payment_method:{ credit_card: 0, bank_transfer: 1}
  enum status:{ waiting: 0, confirm: 1, making: 2, ready_to_ship: 3, sent: 4}
  
  # @orders.order_details
# def self.order_details
#    OrderDetail.where(order_id: self.pluck(:id))
    # @order_details = OrderDetail.where(order_id: @orders.pluck(:id))
#  end
end