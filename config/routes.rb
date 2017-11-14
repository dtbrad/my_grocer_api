Rails.application.routes.draw do
  root to: 'application#info'

  namespace :api do
    namespace :v1 do
      post '/signup', to: "users#signup"
      post '/login', to: "sessions#login"

      get 'products', to: "products#index"
      get 'products_index_total_spent_chart', to: "products#total_spent"
      get 'products_index_qty_bought_chart', to: "products#qty_bought"
      get 'products/:id', to: "products#show"
      get 'product_spending_chart', to: 'products#spending_chart'

      get 'baskets', to: "baskets#index"
      get 'baskets/:id', to: "baskets#show"
      get 'baskets_spending_chart', to: 'baskets#spending_chart'
    end
  end
end
