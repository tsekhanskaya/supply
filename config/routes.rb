# frozen_string_literal: true

Rails.application.routes.draw do
  get 'order_items/create'
  get 'order_items/update'
  get 'order_items/destroy'
  get 'cart/show'
  resources :restaurants
  resources :brands
  devise_for :users
  root to: 'products#index'

  resources :products

  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
end
