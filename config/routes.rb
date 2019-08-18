Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      namespace :merchants do
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
        get '/random', to: 'random#show'
      end

      namespace :customers do
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
        get '/random', to: 'random#show'
      end

      namespace :invoices do
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
        get '/random', to: 'random#show'
      end

      namespace :items do
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
        get '/random', to: 'random#show'
      end

      namespace :invoice_items do
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
        get '/random', to: 'random#show'
      end

      namespace :transactions do
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
        get '/random', to: 'random#show'
      end

      resources :merchants, only: [:index, :show], module: :merchants do
        resources :items, only: [:index]
        resources :invoices, only: [:index]
      end

      resources :customers, only: [:index, :show] do

      end

      resources :items, only: [:index, :show] do

      end

      resources :invoices, only: [:index, :show], module: :invoices do
        resources :transactions, only: [:index]
        resources :invoice_items, only: [:index]
      end

      resources :invoice_items, only: [:index, :show] do

      end

      resources :transactions, only: [:index, :show] do

      end

    end
  end
end
