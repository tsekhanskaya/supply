# frozen_string_literal: true

Rails.application.routes.draw do
  resources :order_items
  # resources :cart
  get 'cart', to: 'cart#show'
  put 'cart', to: 'cart#update'

  resources :restaurants
  resources :brands
  devise_for :users

  root to: 'products#index'

  resources :products

  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
end
