# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root "users#index"

  resources :users, only: [:index, :show] do
    resources :posts
  end
  resources :posts, only: [:index, :new, :create]
  # Defines the root path route ("/")
  # root "articles#index"
end
