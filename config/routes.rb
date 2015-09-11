Rails.application.routes.draw do

  root :to => 'assets#index'
  # root 'homepage#index'

  get  'login'  => 'sessions#new', as: :login
  post 'login'  => 'sessions#create'
  get 'logout'  => 'sessions#destroy', as: :logout

  # Standard Routes
  resources :users do
    member do
      get 'properties'
      get 'rooms'
      get 'devices'
    end
  end

  resources :properties
  resources :rooms
  resources :devices

  # API Routes
  namespace :api do
    resources :users do
      member do
        get 'properties'
        get 'rooms'
        get 'devices'
      end
    end

    resources :properties
    resources :rooms
    resources :devices
  end

end
