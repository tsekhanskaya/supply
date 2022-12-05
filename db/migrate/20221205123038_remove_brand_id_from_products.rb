# frozen_string_literal: true

class RemoveBrandIdFromProducts < ActiveRecord::Migration[7.0]
  def change
    remove_column :products, :brand_id, :integer
  end
end
