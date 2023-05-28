# frozen_string_literal: true

class RestaurantsController < ApplicationController
  before_action :set_restaurant, only: %i[show edit update destroy]

  # GET /restaurants
  def index
    @restaurants = Restaurant.all
  end

  # GET /restaurants/1
  def show; end

  # GET /restaurants/new
  def new
    if can? :create, Restaurant
      @restaurant = Restaurant.new
    else
      render 'errors/not_found'
    end
  end

  # GET /restaurants/1/edit
  def edit
    # render 'errors/not_found' unless can? :update, Restaurant
  end

  # POST /restaurants
  def create
    @restaurant = Restaurant.new(restaurant_params)
    @restaurant.user_id = current_user.id
    respond_to do |format|
      if @restaurant.save
        format.html { redirect_to restaurant_url(@restaurant), notice: t('restaurants.create') }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /restaurants/1
  def update
    respond_to do |format|
      if @restaurant.update(restaurant_params)
        format.html { redirect_to restaurant_url(@restaurant), notice: t('update') }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /restaurants/1
  def destroy
    @restaurant.destroy

    respond_to do |format|
      format.html { redirect_to restaurants_url, notice: t('restaurants.destroy') }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_restaurant
    @restaurant = Restaurant.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def restaurant_params
    params.require(:restaurant).permit(:title, :description, :house, :street, :city, :state, :country, :img, :user_id)
  end
end
