# frozen_string_literal: true

json.extract! restaurant, :id, :title, :description, :address, :img, :created_at, :updated_at
json.url restaurant_url(restaurant, format: :json)
