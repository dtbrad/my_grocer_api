Rails.application.routes.draw do

root to: 'application#info'

  namespace :api do
    namespace :v1 do
      post '/signup', to: "users#signup"
      post '/login', to: "sessions#login"
      get 'products', to: "products#index"
      resources :baskets
      get 'baskets_spending_chart', to: 'baskets#spending_chart'
    end
  end
end
