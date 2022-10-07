# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do 
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root "users#index"

  resources :users, only: [:index, :show] do
    resources :posts do
      resources :comments
      resources :likes, only: [:new, :create]
    end
  end
  # Defines the root path route ("/")
  # root "articles#index"
end
