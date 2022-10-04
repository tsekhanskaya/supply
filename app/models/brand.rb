# frozen_string_literal: true

class Brand < ApplicationRecord
  validates :title, presence: true, length: { maximum: 150 }
  validates :description, length: { maximum: 500 }, allow_blank: true
  validates :address, presence: true
  validates :img, presence: true

  has_many :products, dependent: :destroy
  belongs_to :user
end
