# frozen_string_literal: true

class OrderItem < ApplicationRecord
  belongs_to :product
  belongs_to :order
  # belongs_to :cart
  before_save :set_unit_price
  before_save :set_total

  def unit_price
    # If there is a record
    if persisted?
      self[:unit_price]
    else
      product.price
    end
  end

  def total
    (unit_price * quantity).ceil(2)
  end

  private

  def set_unit_price
    self[:unit_price] = unit_price
  end

  def set_total
    self[:total] = total * quantity
  end
end
