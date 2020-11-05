class Order < ApplicationRecord
  belongs_to :customer
  enum payment_method:[credit_card:0, bank_transfer:1]
  enum status:[waiting:0, confirm:1, making:2, ready_to_ship:3, sent:4]
end
