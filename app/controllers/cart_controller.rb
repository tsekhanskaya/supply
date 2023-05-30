# frozen_string_literal: true

require 'prawn'
require 'prawn/table'
require 'numo/narray'
require 'chartkick'

class CartController < ApplicationController
  def recs
    @products = Product.all
    @categories = Category.all
    popular_products = popular_products_with_names
    @data = popular_products.map { |product_id, count| [Product.find_by(id: product_id).title, count] }

    # Применить фильтрацию по категории, если выбрана
    if params[:category_id].present?
      category_id = params[:category_id].to_i
      @products = @products.where(category_id: category_id)
    end
    session[:selected_product_ids] = params[:product_ids] || []
  end

  def show
    @order_items = current_order.order_items.sort
  end

  # change status
  def update
    if current_order.order_items.empty?
      redirect_to cart_url(@current_order), alert: t('cart.cart_empty')
    else
      current_order.status_id = current_order.status_id + 1
      current_order.save
      redirect_to cart_url(@current_order), notice: t('cart.alert')
    end
  end

  def destroy
    current_order.order_items.each do |order_item|
      quantity = order_item.quantity
      order_item.product.update!(quantity: order_item.product.quantity + quantity)
    end
    current_order.destroy
    render cart_path
  end

  def analyze
    selected_product_ids = params[:product_ids] || []
    products = Product.where(id: selected_product_ids)

    result = []
    products.each do |product|
      # amount = product.order_items.pluck(:quantity)
      amount = product.order_items.joins(:order).where.not('orders.status_id = ?', 1).pluck(:quantity)
      ema = calculate_ema(amount, 10) # Replace 10 with your desired EMA period

      overall = product.price * ema

      information = "#{product.brand.title}, #{product.brand.contacts}"
      result << { product: product.title, original_price: product.price, ema: ema, overall: overall,
                  information: information }

      if current_order.persisted?
        if ema != 0
          if current_order.order_items.find_by(product_id: product.id)
            order_item = current_order.order_items.find_by(product_id: product.id)
            order_item.quantity = ema
            order_item.save
          else
            current_order.order_items.create(product: product, quantity: ema)
          end
        end
      else
        current_order.save
        current_order.order_items.create(product: product, quantity: ema) if ema != 0
      end
    end

    pdf = generate_pdf(result)
    send_data pdf.render, filename: 'analysis_report_.pdf', type: 'application/pdf', disposition: 'inline',
                          notice: t('cart.cart_updated')
  end

  private

  def calculate_ema(counts, period)
    return 0 if counts.empty?

    alpha = 2.0 / (period + 1)
    narray_prices = Numo::DFloat.cast(counts)
    ema_values = Numo::NMath.exp(Numo::NMath.log(narray_prices).cumsum * alpha)
    ema_values[-1].round(0)
  end

  def generate_pdf(result)
    pdf = Prawn::Document.new
    pdf.font_families.update(
      'CyrillicFont' => {
        normal: 'app/assets/fonts/arial-unicode-ms.ttf'
      }
    )
    pdf.font 'CyrillicFont'
    current_time = Time.now
    formatted_time = current_time.strftime('%d.%m.%Y %H:%M')
    pdf.text formatted_time.to_s
    table_data = [[t('cart.table.product'), t('cart.table.original_price'), t('cart.table.ema'),
                   t('cart.table.overall'), t('cart.table.contacts')]]

    total_price = 0

    result.each do |data|
      product = data[:product]
      original_price = data[:original_price]
      ema = data[:ema]
      overall = data[:overall]
      total_price += overall.round(2)
      information = data[:information]
      table_data << [product, original_price, ema, overall.round(2), information]
    end

    pdf.table(table_data, cell_style: { borders: %i[top bottom left right] })
    pdf.text ' '
    pdf.text t('cart.table.total_price') + ": #{total_price.round(2)} BYN"
    pdf.text t('cart.table.manager') + ": #{current_user.email}"
    pdf
  end

  def popular_products_with_names
    OrderItem.joins(:product).group(:product_id, 'products.title')
             .order('COUNT(order_items.product_id) DESC').limit(5)
             .count('order_items.product_id')
  end

  def display_product_chart
    popular_products = popular_products_with_names
    data = popular_products.map { |product_id, count| [Product.find_by(id: product_id).title, count] }
    column_chart(data, xtitle: 'Product', ytitle: 'Sales Count')
  end
end
