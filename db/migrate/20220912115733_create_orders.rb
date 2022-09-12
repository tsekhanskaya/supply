# frozen_string_literal: true

class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.float :subtotal
      t.float :total
      t.integer :restaurant_id
      t.integer :status_id

      t.timestamps
    end
  end
end
