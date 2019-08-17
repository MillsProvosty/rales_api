Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      namespace :merchants do
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
      end


      resources :merchants, only: [:index, :show] do

      end

      resources :customers, only: [:index, :show] do

      end

      resources :items, only: [:index, :show] do

      end

      resources :invoices, only: [:index, :show] do

      end

      resources :invoice_items, only: [:index, :show] do

      end

      resources :transactions, only: [:index, :show] do

      end

    end
  end
end
