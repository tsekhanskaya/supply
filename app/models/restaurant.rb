# frozen_string_literal: true

gem 'geocoder'
class Restaurant < ApplicationRecord
  geocoded_by :address
  after_validation :geocode, if: :address_changed?

  validates :title, presence: true, length: { maximum: 150 }
  validates :description, length: { maximum: 500 }, allow_blank: true
  validates :street, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :country, presence: true
  validates :img, presence: true

  has_many :orders
  has_many :products, through: :orders
  belongs_to :user

  def address
    [house, street, city, state, country].compact.join(', ')
  end

  def address_changed?
    house_changed? || street_changed? || city_changed? || state_changed? || country_changed?
  end
end
