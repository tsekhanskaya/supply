# frozen_string_literal: true

class Product < ApplicationRecord
  validates :title, presence: true, length: { maximum: 150 }
  validates :price, presence: true, numericality: { greater_than: 0, less_than_or_equal_to: 100000000 }
  validates :description, length: { maximum: 500 }, allow_blank: true

  belongs_to :brand
  has_many :orders
  has_many :restaurants, through: :orders
  has_many :order_items

  accepts_nested_attributes_for :brand
end
