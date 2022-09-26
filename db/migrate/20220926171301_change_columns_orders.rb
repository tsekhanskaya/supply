# frozen_string_literal: true

class ChangeColumnsOrders < ActiveRecord::Migration[7.0]
  def change
    rename_column :orders, :order_status_id, :status_id
  end
end
