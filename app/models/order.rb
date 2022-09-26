# frozen_string_literal: true

class Order < ApplicationRecord
  has_many :restaurants
  has_many :order_items, dependent: :destroy
  has_one :status
  before_save :set_total

  def total
    order_items.collect { |order_item| order_item.valid? ? order_item.unit_price * order_item.quantity : 0 }.sum.ceil(2)
  end

  private

  def set_total
    total
  end
end
