# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include ApplicationHelper

  before_action :authenticate_user!

  def after_sign_up_path_for(_resource)
    root_path # or any other path
  end

  def after_sign_out_path_for(_resource_or_scope)
    root_path
  end
end
