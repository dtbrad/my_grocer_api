Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      get 'products', to: "products#index"
      resources :baskets
      get 'spending_history', to: 'baskets#spending_history'
    end
  end
end
