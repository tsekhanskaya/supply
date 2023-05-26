# frozen_string_literal: true

Rails.application.routes.draw do
  get 'errors/not_found'
  get 'errors/internal_server_error'

  # match "/404", to: "errors#not_found", via: :all
  # match "/500", to: "errors#internal_server_error", via: :all

  resources :order_items
  # resources :car
  get 'cart', to: 'cart#show'
  put 'cart', to: 'cart#update'
  get 'cart/recs', to: 'cart#recs', as: 'cart_recs'
  # post 'analyze', to: 'cart#analyze'
  post 'analyze', to: 'cart#analyze', as: 'analyze'
  resources :restaurants
  resources :brands

  namespace :admin do
    get 'user/:id', to: 'users#show'
    get 'users/edit/:id', to: 'users#edit'
    post 'users/edit/:id', to: 'users#update'
    put 'users/edit/:id', to: 'users#update'
    delete 'user/:id', to: 'users#destroy'
    get 'manage-for-users', to: 'users#users_managing'
  end

  devise_for :users

  root to: 'products#index'

  resources :products

  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
end
