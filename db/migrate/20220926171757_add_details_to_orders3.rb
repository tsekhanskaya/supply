# frozen_string_literal: true

class AddDetailsToOrders3 < ActiveRecord::Migration[7.0]
  def change
    change_column :orders, :status_id, :integer, default: 1
  end
end
