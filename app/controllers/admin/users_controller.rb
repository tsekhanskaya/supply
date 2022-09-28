# frozen_string_literal: true

module Admin
  class UsersController < ApplicationController
    before_action :check_for_admin, except: :index
    before_action :set_user, only: %i[show edit_page edit destroy]

    def index
      @user = current_user
    end

    def show; end

    def users_managing
      @users = User.all
    end

    def edit_page
      @user = User.find_by(id: params[:id])
      @admin = @user.admin?
    end

    def edit
      @user = User.find_by(id: params[:id])
      if !params[:user][:password].blank?
        @user.update!(params.require(:user).permit(:email, :password, :role))
        flash[:notice] = "Successfully updated User: #{@user.email}"
      elsif params[:user][:password].blank?
        @user.update!(params.require(:user).permit(:email, :role))
        flash[:notice] = "Successfully updated User: #{@user.email}"
      else
        flash[:alert] = "Can't update User: #{@user.email}"
      end
      redirect_to '/admin/manage-for-users'
    rescue StandardError => e
      flash[:alert] = "Can't update User: #{@user.email}, #{e.message}"
      redirect_to '/admin/manage-for-users'
    end

    def destroy
      User.find(params[:id]).destroy
      redirect_back fallback_location: root_path,
                    notice: 'User was successfully deleted.'
    end

    def password_required?
      false
    end

    private
    def check_for_admin
      redirect_to root_path, alert: 'You dont have access' unless current_user.admin?
    end

    def set_user
      @user = User.find_by(id: params[:id])
    end
  end
end
