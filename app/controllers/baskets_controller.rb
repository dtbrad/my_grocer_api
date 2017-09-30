class BasketsController < ApplicationController
  def index
    baskets = Basket.all
    paginate json: baskets
  end
end
