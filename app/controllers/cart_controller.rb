# frozen_string_literal: true

class CartController < ApplicationController
  def show
    @order_items = current_order.order_items
  end

  def destroy
    current_order.order_items.each do |order_item|
      quantity = order_item.quantity
      order_item.product.update!(quantity: order_item.product.quantity+quantity)
    end
    current_order.destroy
    render :show
  end
end
