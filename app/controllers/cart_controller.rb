# frozen_string_literal: true

class CartController < ApplicationController
  def show
    @order_items = current_order.order_items.sort
  end

  # change status
  def update
    if !current_order.order_items
      current_order.status_id = current_order.status_id + 1
      current_order.save
      redirect_to cart_url(@current_order), notice: 'Order was successfully confirmed.'
    else
      redirect_to cart_url(@current_order), alert: 'Cart is empty.'
    end
  end

  def destroy
    current_order.order_items.each do |order_item|
      quantity = order_item.quantity
      order_item.product.update!(quantity: order_item.product.quantity + quantity)
    end
    current_order.destroy
    render cart_path
  end
end
