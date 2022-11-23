# frozen_string_literal: true

module ApplicationHelper
  def current_order
    @current_order ||= Order.find_by(user_id: current_user.id, status_id: 1) || Order.new(user_id: current_user.id)
  end
end
