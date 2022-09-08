# frozen_string_literal: true

class Order < ApplicationRecord
  belongs_to :restaurant
  belongs_to :product
  has_one :order_status

  def total_price
    self.quantity * self.product.price
  end

  def sub_total
    sum = 0
    orders.each do |line_item|
      sum+= line_item.total_price
    end
    sum
  end
end
