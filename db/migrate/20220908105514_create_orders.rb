# frozen_string_literal: true

class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.integer :product_id
      t.integer :quantity, default: 1
      t.integer :restaurant_id
      t.integer :status_id, default: 1

      t.timestamps
    end
  end
end
