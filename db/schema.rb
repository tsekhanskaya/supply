# frozen_string_literal: true

# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 20_221_005_091_042) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'brands', force: :cascade do |t|
    t.string 'title'
    t.text 'description'
    t.string 'img', default: 'no_image.jpg'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.bigint 'user_id'
    t.string 'house'
    t.string 'street'
    t.string 'city'
    t.string 'state'
    t.string 'country'
    t.float 'latitude'
    t.float 'longitude'
    t.index ['user_id'], name: 'index_brands_on_user_id'
  end

  create_table 'order_items', force: :cascade do |t|
    t.integer 'quantity'
    t.integer 'product_id'
    t.integer 'order_id'
    t.float 'total'
    t.float 'unit_price'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'orders', force: :cascade do |t|
    t.float 'total'
    t.integer 'restaurant_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.integer 'status_id', default: 1
  end

  create_table 'products', force: :cascade do |t|
    t.integer 'brand_id'
    t.string 'title', default: 'No title'
    t.float 'price', default: 0.0
    t.text 'description', default: 'No description'
    t.string 'img', default: 'no_image.jpg'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'restaurants', force: :cascade do |t|
    t.string 'title'
    t.text 'description'
    t.string 'img', default: 'no_image.jpg'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.bigint 'user_id'
    t.string 'street'
    t.string 'city'
    t.string 'state'
    t.string 'country'
    t.float 'latitude'
    t.float 'longitude'
    t.string 'house'
    t.index ['user_id'], name: 'index_restaurants_on_user_id'
  end

  create_table 'statuses', force: :cascade do |t|
    t.integer 'number'
    t.string 'title'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'users', force: :cascade do |t|
    t.string 'email', default: '', null: false
    t.string 'encrypted_password', default: '', null: false
    t.string 'reset_password_token'
    t.datetime 'reset_password_sent_at'
    t.datetime 'remember_created_at'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.boolean 'user_restaurant', default: true
    t.boolean 'user_brand', default: false
    t.boolean 'admin', default: false
    t.index ['email'], name: 'index_users_on_email', unique: true
    t.index ['reset_password_token'], name: 'index_users_on_reset_password_token', unique: true
  end
end
