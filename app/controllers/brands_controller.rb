# frozen_string_literal: true

class BrandsController < ApplicationController
  before_action :set_brand, only: %i[show edit update destroy]

  # GET /brands
  def index
    @brands = Brand.all
  end

  # GET /brands/1
  def show
    @brand = Brand.find_by(id: params[:id])
    return not_found unless @brand

    @products = Product.where(brand_id: @brand.id)
  end

  # GET /brands/new
  def new
    if can? :create, Brand
      @brand = Brand.new
    else
      render 'errors/not_found'
    end
  end

  # GET /brands/1/edit
  def edit
    # render 'errors/not_found' unless can? :update, Brand
  end

  # POST /brands
  def create
    @brand = Brand.new(brand_params)
    @brand.user_id = current_user.id

    respond_to do |format|
      if @brand.save
        format.html { redirect_to brand_url(@brand), notice: t('brands.create') }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /brands/1
  def update
    respond_to do |format|
      if @brand.update(brand_params)
        format.html { redirect_to brand_url(@brand), notice: t('update') }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /brands/1
  def destroy
    @brand.destroy

    respond_to do |format|
      format.html { redirect_to brands_url, notice: t('brands.destroy') }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_brand
    @brand = Brand.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def brand_params
    params.require(:brand).permit(:title, :description, :address, :img, :house, :street, :city, :state, :country)
  end
end
