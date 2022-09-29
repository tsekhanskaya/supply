# frozen_string_literal: true

module Admin
  class UsersController < ApplicationController
    before_action :check_for_admin
    before_action :set_user, only: %i[show edit destroy]

    def users_managing
      @users = User.all
    end

    def edit; end

    def destroy
      User.find(params[:id]).destroy
      redirect_back fallback_location: root_path,
                    notice: 'User was successfully deleted.'
    end

    def update
      respond_to do |format|
        if @user.update(user_params)
          format.html { redirect_to brand_url(@user), notice: 'User was successfully updated.' }
        else
          format.html { render :edit, status: :unprocessable_entity }
        end
      end
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

    def user_params
      params.require(:user).permit(:role)
    end
  end
end
