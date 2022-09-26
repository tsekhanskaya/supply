# frozen_string_literal: true

class AddDetailsToOrders < ActiveRecord::Migration[7.0]
  def change
    change_table :orders do |t|
      t.remove :total, :status_id
      t.rename :subtotal, :total
    end
  end
end
