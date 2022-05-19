Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      get '/merchants/find_all', to: 'merchant_search#search'
      get '/items/find', to: 'item_search#search'

      resources :merchants, only: [:index, :show]

      get '/merchants/:id/items', to: 'merchant_items#index'

      resources :items, only: [:index, :show, :create, :update, :destroy]

      get '/items/:id/merchant', to: 'item_merchants#show'
    end
  end
end
#   namespace :api do
#     namespace :v1 do
#       get '/merchants/:id/items', to: 'items#index'
#       resources :merchants, only: [:index, :show]
#       resources :items, only: [:index, :show, :create, :update, :destroy]
#     end
#   end
# end
