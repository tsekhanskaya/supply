# frozen_string_literal: true

class Restaurant < ApplicationRecord
  validates :title, presence: true, length: { maximum: 150 }
  validates :description, length: { maximum: 500 }, allow_blank: true
  validates :address, presence: true
  validates :img, presence: true

  has_many :orders
  has_many :products, through: :orders
  belongs_to :user
end
