# frozen_string_literal: true

class OrderItemsController < ApplicationController
  before_action :set_order
  def create
    if can? :create, OrderItem
      if @order.order_items.find_by(product_id: order_params[:product_id])
        @order_item = @order.order_items.find_by(product_id: order_params[:product_id])
        @order_item.quantity += order_params[:quantity].to_i
        @order_items = current_order.order_items if @order_item.save
      else
        @order_items = @order.order_items.new(order_params)
      end
      @order.save
      redirect_back fallback_location: '/'
    end
  end

  def update
    @order_item = @order.order_items.find(params[:id])
    @order_item.assign_attributes(order_params)
    @order_items = current_order.order_items if @order_item.save
    redirect_back fallback_location: '/'
  end

  def destroy
    @order_item = @order.order_items.find(params[:id])
    @order_item.destroy
    @order_items = current_order.order_items
    redirect_back fallback_location: '/'
  end

  private

  def order_params
    params.require(:order_item).permit(:quantity, :product_id, :order_id, :unit_price)
  end

  def set_order
    @order = current_order
  end
end
