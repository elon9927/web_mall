Rails.application.routes.draw do
  root 'home#index'

  resources :users
  resources :sessions
  delete '/logout' => 'sessions#destroy', as: :logout
  resources :categories, only: [:show]
  resources :products, only: [:show] do
    get :search, on: :collection
  end
  resources :carts
  resources :orders
  resources :addresses do
    member do
      put :set_default_address
    end
  end

  resources :orders
  resources :payments, only: [:index]

  namespace :admin do
    root 'sessions#new'
    resources :sessions
    resources :categories
    resources :products

  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
