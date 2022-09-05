# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  root to: 'products#index'

  resources :products

  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
end
