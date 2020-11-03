class Item < ApplicationRecord
  has_many :cart_item, dependent: :destroy
  belongs_to :genre
  attachment :image
end
