Rails.application.routes.draw do
  root 'home#index'

  resources :users do
    post :send_sms, on: :collection
  end
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

  resources :payments, only: [:index] do
    collection do
      get :generate_pay
      get :pay_return
      get :pay_notify
      get :success
      get :failed
    end
  end

  namespace :dashboard do
    scope 'profile' do
      controller :profile do
        get :password
        put :update_password
      end
    end

    resources :orders, only: [:index]
    resources :addresses, only: [:index]
  end

  namespace :admin do
    root 'home#index'
    resources :sessions
    resources :categories
    resources :products
    resources :users, only: [:index] do
      member do
        put :set_role
      end
    end
    delete '/logout' => 'sessions#destroy', as: :logout

  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
