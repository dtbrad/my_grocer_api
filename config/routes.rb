Rails.application.routes.draw do
  get 'baskets/index'

  get '/products', to: "products#index"

  get '/baskets', to: "baskets#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
