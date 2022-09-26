# frozen_string_literal: true

class AddDetailsToOrders2 < ActiveRecord::Migration[7.0]
  def change
    add_column :orders, :order_status_id, :integer, default: 0
  end
end
