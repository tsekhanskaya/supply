# frozen_string_literal: true

json.extract! brand, :id, :title, :description, :address, :img, :created_at, :updated_at
json.url brand_url(brand, format: :json)
