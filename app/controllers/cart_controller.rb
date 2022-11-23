# frozen_string_literal: true

class CartController < ApplicationController
  def show
    @order_items = current_order.order_items.sort
  end

  # change status
  # def update
  #   current_order.status_id = current_order.status_id + 1
  #   current_order.update(order_params)
  #   redirect_to cart_url(@current_order), notice: 'Order was successfully confirmed.'
  # end

  def destroy
    current_order.order_items.each do |order_item|
      quantity = order_item.quantity
      order_item.product.update!(quantity: order_item.product.quantity + quantity)
    end
    current_order.destroy
    render cart_path
  end

  # def order_params
  #   params.require(:order).permit(:total, :status_id, :restaurant_id)
  # end
end
