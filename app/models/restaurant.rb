# frozen_string_literal: true

class Restaurant < ApplicationRecord
  has_many :orders
  has_many :products, through: :orders
end
