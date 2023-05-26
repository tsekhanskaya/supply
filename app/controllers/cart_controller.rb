# frozen_string_literal: true

class CartController < ApplicationController
  def show
    # if current_user.user_restaurant? or current_user.admin?
    @order_items = current_order.order_items.sort
    # end
    # if current_user.user_brand?
    #   current_order = Order.find_by(status_id: 2)
    #   @order_items = current_order.order_items
    #   unless @order_items.empty?
    #     @order_items.find_by(product_id: Product.find_by(brand_id: Brand.where(user_id: current_user.id)))
    #   end
    # end
  end

  # change status
  def update
    if current_order.order_items.empty?
      redirect_to cart_url(@current_order), alert: 'Cart is empty.'
    else
      current_order.status_id = current_order.status_id + 1
      current_order.save
      redirect_to cart_url(@current_order), notice: 'Order was successfully confirmed.'
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
