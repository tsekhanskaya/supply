# frozen_string_literal: true

class CreateOrderStatuses < ActiveRecord::Migration[7.0]
  def change
    create_table :order_statuses do |t|
      t.integer :number
      t.string :status

      t.timestamps
    end
  end
end
