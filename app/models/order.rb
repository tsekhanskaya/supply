# frozen_string_literal: true

class Order < ApplicationRecord
  belongs_to :restaurant
  belongs_to :product
  has_one :order_status
end
