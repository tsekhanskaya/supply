# frozen_string_literal: true

class Product < ApplicationRecord
  belongs_to :brand
  has_many :orders
  has_many :restaurants, through: :orders
  has_many :order_items

  accepts_nested_attributes_for :brand
end
