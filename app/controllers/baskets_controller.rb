class BasketsController < ApplicationController
  def index
    baskets = Basket.within_date_range(params)
    paginate json: baskets
  end
end
