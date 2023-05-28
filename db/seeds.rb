# frozen_string_literal: true

if Rails.env.development?
  # AdminUser.create!(email: 'admin@example.com', password: 'password',
  #                   password_confirmation: 'password')

  20.times do
    product = Product.create(
      title: Faker::Food.dish,
      price: Faker::Number.decimal(l_digits: 2),
      description: Faker::Lorem.sentence,
      category_id: Category.pluck(:id).sample,
      brand_id: Brand.pluck(:id).sample
    )

    puts "Создан продукт: #{product.title}"
  end
end
