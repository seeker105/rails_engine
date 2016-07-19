Rails.application.routes.draw do



    namespace :api do
      namespace :v1 do
        namespace :invoice_items do
          get 'find', to: 'find#show'
          get 'find_all', to: 'find#index'
          get 'random', to: 'random#show'
        end
        resources :merchants, except: [:new, :edit], defaults: {format: :json}
        resources :invoices, except: [:new, :update], defaults: {format: :json}
      end
    end
  end
