# frozen_string_literal: true

json.extract! product, :id, :brand_id, :title, :price, :description, :img, :created_at, :updated_at
json.url product_url(product, format: :json)
