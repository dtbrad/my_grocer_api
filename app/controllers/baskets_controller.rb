class BasketsController < ApplicationController
  def index
    baskets = Basket.within_date_range(params)
    paginate json: baskets
  end

  def spending_history
    spending = Basket.group_baskets(params)
    render json: spending
  end
end
