# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post 'authenticate', to: 'authentication#create'
      resources :users do
        resources :posts do
          resources :comments
        end
      end
    end
  end

  devise_for :users
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root 'users#index'

  resources :users, only: %i[index show] do
    resources :posts do
      resources :comments
      resources :likes, only: %i[new create]
    end
  end
  # Defines the root path route ("/")
  # root "articles#index"
end
