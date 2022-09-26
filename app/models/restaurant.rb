# frozen_string_literal: true

class Restaurant < ApplicationRecord
  has_many :orders
  has_many :products, through: :orders
  has_many :restaurants
end
