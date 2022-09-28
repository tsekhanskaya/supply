# frozen_string_literal: true

Rails.application.routes.draw do
  get 'errors/not_found'
  get 'errors/internal_server_error'

  # match "/404", to: "errors#not_found", via: :all
  # match "/500", to: "errors#internal_server_error", via: :all

  resources :order_items
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

  namespace :admin do
    get 'user/:id', to: 'users#show'
    get 'user/edit/:id', to: 'users#edit_page'
    put 'user/edit/:id', to: 'users#edit'
    delete 'user/:id', to: 'users#destroy'
    get 'manage-for-users', to: 'users#users_managing'
  end
end
