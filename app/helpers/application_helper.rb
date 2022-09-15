# frozen_string_literal: true

module ApplicationHelper
  # def current_order
  #   @current_order ||= Order.find_by_id(session[:order_id]).presence || Order.new
  # end

  # def current_order
  #   # Use find by id to avoid potential errors
  #   if Order.find(session[:order_id]).nil?
  #     Order.new
  #   else
  #     Order.find(session[:order_id])
  #   end
  # end

  # def current_order
  #   @current_order ||= begin
  #     Order.find_or_create_by(order: current_order)
  #   end
  # end
end
