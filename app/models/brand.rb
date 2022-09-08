# frozen_string_literal: true

class Brand < ApplicationRecord
  has_many :products, dependent: :destroy
end
