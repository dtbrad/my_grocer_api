class Api::V1::BasketsController < ApplicationController

  def index
    baskets = Basket.within_date_range(params).custom_sort(params)
    paginate json: baskets
  end

  def spending_history
    spending = Basket.group_baskets(params)
    render json: spending
  end

end
