class Order < ApplicationRecord
  belongs_to :restaurant
  belongs_to :product
  has_one :order_status
end
