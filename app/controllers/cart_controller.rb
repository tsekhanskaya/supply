# frozen_string_literal: true

require 'prawn'
require 'prawn/table'
require 'numo/narray'
require 'chartkick'

class CartController < ApplicationController
  def recs
    @products = Product.all
    popular_products = popular_products_with_names
    @data = popular_products.map { |product_id, count| [Product.find_by(id: product_id).title, count] }
  end

  def show
    @order_items = current_order.order_items.sort
  end

  # change status
  def update
    if current_order.order_items.empty?
      redirect_to cart_url(@current_order), alert: 'Cart is empty.'
    else
      current_order.status_id = current_order.status_id + 1
      current_order.save
      redirect_to cart_url(@current_order), notice: 'Order was successfully confirmed.'
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
      prices = product.order_items.pluck(:unit_price)
      ema = calculate_ema(prices, 10) # Replace 10 with your desired EMA period

      overall = product.price * ema

      information = product.brand.description
      result << { product: product.title, original_price: product.price, ema: ema, overall: overall,
                  information: information }
    end

    pdf = generate_pdf(result)
    send_data pdf.render, filename: 'analysis_report.pdf', type: 'application/pdf', disposition: 'inline'
  end

  private

  def calculate_ema(prices, period)
    alpha = 2.0 / (period + 1)
    narray_prices = Numo::DFloat.cast(prices)
    ema_values = Numo::NMath.exp(Numo::NMath.log(narray_prices).cumsum * alpha)
    ema_values[-1].round(1)
  end

  def generate_pdf(result)
    pdf = Prawn::Document.new
    pdf.font_families.update(
      'CyrillicFont' => {
        normal: 'app/assets/fonts/arial-unicode-ms.ttf'
      }
    )
    pdf.font 'CyrillicFont'
    table_data = [['Product', 'Original Price', 'EMA', 'Overall', 'Information']]

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
    pdf.text "Total price: #{total_price}"
    pdf.text "Manager of supply: #{current_user.email}"
    pdf
  end

  def popular_products_with_names
    OrderItem.joins(:product).group(:product_id, 'products.title')
             .order('COUNT(order_items.product_id) DESC').limit(5)
             .count('order_items.product_id')

    # Возвращаем результат в виде хэша, где ключами являются названия продуктов, а значениями - количество заказов.
  end

  def display_product_chart
    popular_products = popular_products_with_names

    data = popular_products.map { |product_id, count| [Product.find_by(id: product_id).title, count] }

    # Здесь используется метод column_chart из библиотеки Chartkick для отображения столбчатой диаграммы продуктов.
    column_chart(data, xtitle: 'Product', ytitle: 'Sales Count')
  end
end
