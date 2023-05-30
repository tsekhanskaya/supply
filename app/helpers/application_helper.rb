# frozen_string_literal: true

module ApplicationHelper
  def current_order
    @current_order ||= Order.find_by(user_id: current_user.id, status_id: 1) || Order.new(user_id: current_user.id)
  end

  def current_products
    if current_user.user_brand? || current_user.admin?
      @current_products = Product.where(brand_id: Brand.find(user_id: current_user.id))
    end
  end

  def toggle_direction(attribute)
    if params[:sort] == attribute && params[:direction] == 'asc'
      'desc'
    else
      'asc'
    end
  end
end
