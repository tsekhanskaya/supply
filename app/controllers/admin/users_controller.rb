# frozen_string_literal: true

module Admin
  class UsersController < ApplicationController
    before_action :check_for_admin
    before_action :set_user, only: %i[show edit destroy update]
    before_action :user_params, only: :update

    def users_managing
      @users = User.all
    end

    def edit; end

    def destroy
      @user.destroy
      redirect_to fallback_location: root_path,
                    notice: 'User was successfully deleted.'
    end

    def update
      respond_to do |format|
        if @user.update(user_params)
          format.html { redirect_to admin_manage_for_users_path, notice: 'User was successfully updated.' }
        else
          format.html { render :edit, status: :unprocessable_entity }
        end
      end
    end

    private

    def check_for_admin
      redirect_to root_path, alert: 'You dont have access' unless current_user.admin?
    end

    def set_user
      @user = User.find_by(id: params[:id])
    end

    def user_params
      params.require(:user).permit(:role.to_s.to_i, :email)
    end
  end
end
